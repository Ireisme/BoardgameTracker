module PlayerStats
  module SessionStats
    extend ActiveSupport::Concern

      def session_count
        SessionPlayer.where('player_id = ?', @player_id).distinct.count(:session_id)
      end

      def favorite_game
        subquery = SessionPlayer.joins(:session)
                       .where('player_id = ?', @player_id)
                       .group('sessions.id')
                       .select('sessions.game_id')

        game_id = Game.from(subquery)
                      .group('game_id')
                      .select('game_id')
                      .order('count(game_id) desc')
                      .first
                      .game_id

        return Game.find(game_id)
      end
  end
end