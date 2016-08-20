module PlayerStats
  module SessionStats
    extend ActiveSupport::Concern

      def session_count
        SessionPlayer.where('player_id = ?', @player_id).distinct.count(:session_id)
      end

      def most_played_game
        subquery = SessionPlayer.joins(:session)
                       .where('player_id = ?', @player_id)
                       .group('sessions.id')
                       .select('sessions.game_id')

        game_result = Game.from(subquery)
                      .group('game_id')
                      .select('game_id, count(game_id) as session_count')
                      .order('count(game_id) desc')
                      .first
        return nil unless game_result

        game = Game.find(game_result.game_id)
        return PlayerStats::GameSessionCount.new(game, game_result.session_count)
      end
  end
end