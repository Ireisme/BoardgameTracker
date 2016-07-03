module PlayerStats
  class GameWinPercent
    def initialize(game, win_percent)
      @game = game
      @win_percent = win_percent
    end

    attr_accessor :game, :win_percent
  end
end