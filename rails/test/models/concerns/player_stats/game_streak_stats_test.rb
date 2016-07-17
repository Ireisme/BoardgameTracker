require 'test_helper'

class GameStreakStatsTest < ActiveSupport::TestCase
  include GameCreation, PlayerCreation, SessionCreation

  context 'best streak calculation' do
    should 'return 0 when no games have ever been won' do
      player = create_player
      game = create_game
      create_session(game, losing_players: [player])

      best_streak = PlayerStatistic.new(player.id).best_streak

      assert_equal 0, best_streak
    end

    should 'chose current streak if it is the best' do
      player = create_player
      game = create_game
      start_date = Date.today
      create_session(game, winning_players: [player], played: start_date)
      create_session(game, losing_players: [player], played: (start_date + 1))
      2.times { create_session(game, winning_players: [player], played: start_date + 2) }

      best_streak = PlayerStatistic.new(player.id).best_streak

      assert_equal 2, best_streak
    end
    should 'chose previous streak if it is the best' do
      player = create_player
      game = create_game
      start_date = Date.today
      2.times { create_session(game, winning_players: [player], played: start_date) }
      create_session(game, losing_players: [player], played: (start_date + 1))

      best_streak = PlayerStatistic.new(player.id).best_streak

      assert_equal 2, best_streak
    end

    should 'chose best streak count in event of tie' do
      player = create_player
      game = create_game
      start_date = Date.today
      2.times { create_session(game, winning_players: [player], played: start_date) }
      create_session(game, losing_players: [player], played: (start_date + 1))
      2.times { create_session(game, winning_players: [player], played: (start_date + 2)) }

      best_streak = PlayerStatistic.new(player.id).best_streak

      assert_equal 2, best_streak
    end

    should 'choose best placing in game when playing as multiple players' do
      player = create_player
      game = create_game
      start_date = Date.today
      create_session(game, winning_players: [player], played: start_date)
      create_session(game, losing_players: [player], played: (start_date + 1))
      2.times { create_session(game, winning_players: [player], losing_players: [player], played: (start_date + 2)) }

      best_streak = PlayerStatistic.new(player.id).best_streak

      assert_equal 2, best_streak
    end

    should 'order games created on same date by create ordering when determining streak' do
      player = create_player
      game = create_game
      start_date = Date.today
      create_session(game, winning_players: [player], played: start_date)
      create_session(game, losing_players: [player], played: start_date)
      2.times { create_session(game, winning_players: [player], played: start_date) }

      best_streak = PlayerStatistic.new(player.id).best_streak

      assert_equal 2, best_streak
    end

    should 'count the first game played in streak' do
      player = create_player
      game = create_game
      2.times { create_session(game, winning_players: [player]) }

      best_streak = PlayerStatistic.new(player.id).best_streak

      assert_equal 2, best_streak
    end
  end
end