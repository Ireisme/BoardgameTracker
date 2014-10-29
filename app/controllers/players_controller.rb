class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
  end

  def create
    @player = Player.new(player_params)
    @player.save
    redirect_to root_path
  end

  def show
    @player = Player.find(params[:id])
  end

  private
    def player_params
      params.require(:player).permit(:name, :powers)
    end
end
