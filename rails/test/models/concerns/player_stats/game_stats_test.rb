require 'test_helper'

class GameStatsTest < ActiveSupport::TestCase
  include GameCreation, PlayerCreation, SessionCreation

  test 'should calculate best game based upon win %' do
    player = create_player
    other_player = create_player
    game_one = create_game ('best')
    game_two = create_game
    3.times { create_session(game_one, winning_players: [player]) }
    create_session(game_two, winning_players: [player], losing_players: [other_player])
    create_session(game_two, winning_players: [other_player], losing_players: [player])

    best_game = PlayerStatistic.new(player.id).best_game

    assert_equal game_one, best_game.game
    assert_equal 1, best_game.win_percent
  end

  test 'should calculate best game win % correctly for normal case' do
    player = create_player
    game = create_game ('best')
    3.times { create_session(game, winning_players: [player]) }
    create_session(game, losing_players: [player])

    best_game = PlayerStatistic.new(player.id).best_game

    assert_equal game, best_game.game
    assert_equal 0.75, best_game.win_percent
  end

  test 'should chose an arbitrary best game when multiple are tied' do
    player = create_player
    game_one = create_game
    game_two = create_game ('other')
    create_session(game_one, winning_players: [player])
    create_session(game_two, winning_players: [player])

    best_game = PlayerStatistic.new(player.id).best_game

    assert_includes [game_one, game_two], best_game.game
    assert_equal 1, best_game.win_percent
  end

  test 'should choose best placing in game when playing as multiple players for best game calculation' do
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