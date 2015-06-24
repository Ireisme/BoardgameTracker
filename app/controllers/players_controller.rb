class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
  end

  def list
    players = Player.all
    render :json => players
  end

  def create
    @player = Player.new(player_params)
    @player.save
    redirect_to root_path
  end

  def show
    session_id = params[:id].to_i
    not_found if session_id < 0

    @player = Player.find(session_id)
  end

  private
    def player_params
      params.require(:player).permit(:name, :powers)
    end
end
