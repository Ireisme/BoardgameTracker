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

    @totals = Session.joins(:session_player)
      .select('session_players.player_id, count(*) as plays, sum(case "placing" when 1 then 1 else 0 end) as wins')
      .where('game_id = ?', params[:id])
      .group('session_players.player_id')
      .order('wins DESC')

    @winner = @totals.first
    @loser = @totals.last

    @loser_percentage = (@loser.wins.to_f / @loser.plays.to_f) * 100
    @winner_percentage = (@winner.wins.to_f / @winner.plays.to_f) * 100

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
