module PlayerStats
  module GameStats
    extend ActiveSupport::Concern

      def best_game
        subquery = SessionPlayer.joins(:session)
                       .group('sessions.id, sessions.game_id')
                       .where('player_id = ?', @player_id)
                       .select('sessions.game_id,
                          CASE MIN("placing") WHEN 1 THEN 1 ELSE 0 END as didWin ')

        # In win_percentage calculation, have to cast one operand to float to ensure float result
        query_result = Game.from(subquery)
                      .group('game_id')
                      .select('game_id,
                         sum(subquery.didWin) / count(*)::float as win_percentage')
                      .order('win_percentage desc')
                      .first

        return to_percent(query_result)
      end

      def worst_game
        subquery = SessionPlayer.joins(:session)
                       .group('sessions.id, sessions.game_id')
                       .where('player_id = ?', @player_id)
                       .select('sessions.game_id,
                          CASE MAX("placing") WHEN 1 THEN 1 ELSE 0 END as didWin ')

        # In win_percentage calculation, have to cast one operand to float to ensure float result
        query_result = Game.from(subquery)
                           .group('game_id')
                           .select('game_id,
                         sum(subquery.didWin) / count(*)::float as win_percentage')
                           .order('win_percentage asc')
                           .first

        return to_percent(query_result)
      end

      private
        def to_percent (game_total)
          return nil unless game_total
          game = Game.find(game_total.game_id)
          return PlayerStats::GameWinPercent.new(game, game_total.win_percentage)
        end
  end
end