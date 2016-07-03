require 'test_helper'

class GameStatsTest < ActiveSupport::TestCase
  include GameCreation, PlayerCreation, SessionCreation

  context 'best game calculation' do
    should 'should calculate based upon win %' do
      player = create_player
      other_player = create_player ('other')
      game_one = create_game ('best')
      game_two = create_game
      3.times { create_session(game_one, winning_players: [player]) }
      create_session(game_two, winning_players: [player], losing_players: [other_player])
      create_session(game_two, winning_players: [other_player], losing_players: [player])

      best_game = PlayerStatistic.new(player.id).best_game

      assert_equal game_one, best_game.game
      assert_equal 1, best_game.win_percent
    end

    should 'should calculate win % correctly for normal case' do
      player = create_player
      game = create_game ('best')
      3.times { create_session(game, winning_players: [player]) }
      create_session(game, losing_players: [player])

      best_game = PlayerStatistic.new(player.id).best_game

      assert_equal game, best_game.game
      assert_equal 0.75, best_game.win_percent
    end

    should 'should chose an arbitrary game when multiple are tied' do
      player = create_player
      game_one = create_game
      game_two = create_game ('other')
      create_session(game_one, winning_players: [player])
      create_session(game_two, winning_players: [player])

      best_game = PlayerStatistic.new(player.id).best_game

      assert_includes [game_one, game_two], best_game.game
      assert_equal 1, best_game.win_percent
    end

    should 'should choose best placing in game when playing as multiple players' do
      player = create_player
      game_one = create_game
      game_two = create_game ('other')
      create_session(game_one, winning_players: [player])
      create_session(game_one, losing_players: [player])
      create_session(game_two, winning_players: [player])
      create_session(game_two, losing_players: [player])
      2.times { create_session(game_one, winning_players: [player], losing_players: [player]) }

      best_game = PlayerStatistic.new(player.id).best_game

      assert_equal game_one, best_game.game
      assert_equal 0.75, best_game.win_percent
    end
  end

  context 'worst game calculation' do
    should 'should calculate based upon loss %' do
      player = create_player
      other_player = create_player ('other')
      game_one = create_game ('worst')
      game_two = create_game
      3.times { create_session(game_one, losing_players: [player]) }
      create_session(game_two, winning_players: [other_player], losing_players: [player])
      create_session(game_two, winning_players: [player], losing_players: [other_player])

      worst_game = PlayerStatistic.new(player.id).worst_game

      assert_equal game_one, worst_game.game
      assert_equal 0, worst_game.win_percent
    end

    should 'should calculate win % correctly for normal case' do
      player = create_player
      game = create_game ('worst')
      3.times { create_session(game, losing_players: [player]) }
      create_session(game, winning_players: [player])

      worst_game = PlayerStatistic.new(player.id).worst_game

      assert_equal game, worst_game.game
      assert_equal 0.25, worst_game.win_percent
    end

    should 'should chose an arbitrary game when multiple are tied' do
      player = create_player
      game_one = create_game
      game_two = create_game ('other')
      create_session(game_one, losing_players: [player])
      create_session(game_two, losing_players: [player])

      worst_game = PlayerStatistic.new(player.id).worst_game

      assert_includes [game_one, game_two], worst_game.game
      assert_equal 0, worst_game.win_percent
    end

    should 'should choose worst placing in game when playing as multiple players' do
      player = create_player
      game_one = create_game
      game_two = create_game ('other')
      create_session(game_one, winning_players: [player])
      create_session(game_one, losing_players: [player])
      create_session(game_two, winning_players: [player])
      create_session(game_two, losing_players: [player])
      2.times { create_session(game_one, winning_players: [player], losing_players: [player]) }

      best_game = PlayerStatistic.new(player.id).worst_game

      assert_equal game_one, best_game.game
      assert_equal 0.25, best_game.win_percent
    end
  end
end