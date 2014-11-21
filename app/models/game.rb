class Game < ActiveRecord::Base
  has_many :sessions

  def best_player
    game_totals.first
  end

  def worst_player
    game_totals.last
  end

  private
  def game_totals
    # Have to declare win_percentage because (wins / plays) doesn't work in ordering
    # In win_percentage calculation, have to cast one operand to float to ensure float result
    Session.joins(:session_players)
      .select('session_players.player_id,
               count(*) as plays,
               sum(case "placing"
                  when 1 then 1
                  else 0 end) as wins,
               (sum(CASE "placing" WHEN 1 THEN 1 ELSE 0 END) / count(*)::float) as win_percentage')
      .where('game_id = ?', id)
      .group('session_players.player_id')
      .order('win_percentage desc')
  end
end
