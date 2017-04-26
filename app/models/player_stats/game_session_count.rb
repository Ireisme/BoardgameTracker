module PlayerStats
  class GameSessionCount
    def initialize(game, session_count)
      @game = game
      @session_count = session_count
    end

    attr_reader :game, :session_count
  end
end