class GamesController < ApplicationController

  def create
    @game = Game.new(game_params)
    @game.save
    render :json => @game.id
  end

  def show
    game = Game.find(params[:id])
    @played_count = Session.where('game_id = ?', params[:id]).count

    render :json => game, :serializer => Games::ShowSerializer
  end

  def list
    games = Game.all
    render :json => games, each_serializer: Games::ListSerializer
  end

  private
    def game_params
      p = params.require(:game).permit(:name, :coop, :game_type, :description, :image)
      p[:game_type] = p[:game_type].to_i unless p[:game_type].nil?
      return p
    end
end
