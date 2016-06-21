module PlayerStats
  module SessionStats
    extend ActiveSupport::Concern

      def session_count
        SessionPlayer.where('player_id = ?', @player_id).distinct.count(:session_id)
      end
  end
end