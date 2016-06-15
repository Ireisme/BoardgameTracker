module Games
  module StatsRetriever
      extend ActiveSupport::Concern

      def best_player
        return to_stats(game_totals.first)
      end

      def worst_player
        return to_stats(game_totals.last)
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

        def to_stats (game_total)
          return nil unless game_total
          player_stats = Games::PlayerStats.new
          player_stats.win_percent = game_total.win_percentage
          player_stats.player = Player.find(game_total.player_id)
          return player_stats
        end
  end
end