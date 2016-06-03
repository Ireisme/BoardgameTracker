class GamesController < ApplicationController

  def create
    @game = Game.new(game_params)
    @game.save
    render :json => @game.id
  end

  def show
    game = Game.find(params[:id])
    @played_count = Session.where('game_id = ?', params[:id]).count

    @winner = game.best_player
    @loser = game.worst_player

    if !@winner.nil?
      @winner_percentage = @winner.win_percentage * 100
      @winning_player = Player.find(@winner.player_id)
    end

    if !@loser.nil?
      @loser_percentage =  @loser.win_percentage * 100
      @losing_player = Player.find(@loser.player_id)
    end
    render :json => game
  end

  def list
    games = Game.all
    render :json => games, each_serializer: Games::ListSerializer
  end

  private
    def game_params
      params.require(:game).permit(:name, :coop, :description, :image)
    end
end
