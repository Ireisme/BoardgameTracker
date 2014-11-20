class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
  end

  def create
    @game = Game.new(game_params)
    @game.save
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
    @played_count = Session.where('game_id = ?', params[:id]).count

    @winner = @game.best_player
    @loser = @game.worst_player

    @loser_percentage = @loser.win_percentage * 100
    @winner_percentage = @winner.win_percentage * 100

    @winning_player = Player.find(@winner.player_id)
    @losing_player = Player.find(@loser.player_id)
  end

  def list
    games = Game.all
    render :json => games
  end

  private
    def game_params
      params.require(:game).permit(:name, :coop, :description)
    end
end
