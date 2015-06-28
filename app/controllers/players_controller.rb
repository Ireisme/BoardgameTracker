class PlayersController < ApplicationController
  def index
    @players = get_filtered_players
  end

  def new
  end

  def list
    players = get_filtered_players
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

    def get_filtered_players
      Player.all.select { |player| player.id > 0 }
    end
end
