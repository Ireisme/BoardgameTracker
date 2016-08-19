class PlayerStatistic
  def initialize(player_id)
    @player_id = player_id
  end

  include PlayerStats::SessionStats, PlayerStats::GameStats, PlayerStats::GameStreakStats
end