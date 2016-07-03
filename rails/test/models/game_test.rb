require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'should calculate best player' do
    @game = Game.find(ActiveRecord::FixtureSet.identify(:game_one))
    @best = @game.best_player
    assert_equal ActiveRecord::FixtureSet.identify(:candyce), @best.player.id, 'returned best player'
    assert_equal 1, @best.win_percent, 'calculated win percent'
  end

  test 'should calculate worst player' do
    @game = Game.find(ActiveRecord::FixtureSet.identify(:game_one))
    @worst = @game.worst_player
    assert_equal ActiveRecord::FixtureSet.identify(:brian), @worst.player.id, 'returned worst player'
    assert_equal 0.25, @worst.win_percent, 'calculated win percent'
  end
end
