class PlayerStatistic
  attr_reader :player_id

  def initialize(player_id)
    @player_id = player_id
  end

  include ActiveModel::Serialization
  include PlayerStats::SessionStats, PlayerStats::GameStats, PlayerStats::GameStreakStats
end