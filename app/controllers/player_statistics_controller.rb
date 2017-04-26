class PlayerStatisticsController < ApplicationController
  before_action :authenticate_user!

  def show
    player_id = params[:id].to_i
    not_found if player_id < 0 or !Player.exists?(player_id)

    stats = PlayerStatistic.new(player_id)
    render :json => stats
  end
end
