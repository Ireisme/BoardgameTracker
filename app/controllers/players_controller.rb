class PlayersController < ApplicationController
  def list
    players = params[:include_unknown] ? Player.all : get_filtered_players
    render :json => players, each_serializer: Players::ListSerializer
  end

  def create
    @player = Player.new(player_params)
    @player.save
    render :json => @player.id
  end

  def show
    session_id = params[:id].to_i
    not_found if session_id < 0

    player = Player.find(session_id)
    render :json => player
  end

  private
    def player_params
      params.require(:player).permit(:name, :powers)
    end

    def get_filtered_players
      Player.all.select { |player| player.id > 0 }
    end

end
