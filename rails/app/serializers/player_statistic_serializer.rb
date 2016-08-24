class PlayerStatisticSerializer < ActiveModel::Serializer
  attributes :player_id, :session_count, :most_played_game,
             :best_game, :worst_game, :win_rate, :best_streak,
             :current_streak
end
