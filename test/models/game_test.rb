require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'should calculate best player' do
    @game = Game.find(ActiveRecord::FixtureSet.identify(:game_one))
    @best = @game.best_player
    assert_equal ActiveRecord::FixtureSet.identify(:candyce), @best.player_id, 'returned best player'
    assert_equal 1, @best.win_percentage, 'calculated win percentage'
  end

  test 'should calculate worst player' do
    @game = Game.find(ActiveRecord::FixtureSet.identify(:game_one))
    @worst = @game.worst_player
    assert_equal ActiveRecord::FixtureSet.identify(:brian), @worst.player_id, 'returned worst player'
    assert_equal 0.25, @worst.win_percentage, 'calculated win percentage'
  end
end
