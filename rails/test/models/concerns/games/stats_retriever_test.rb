require 'test_helper'

class StatsRetrieverTest < ActiveSupport::TestCase
  include GameCreation, PlayerCreation, SessionCreation

  test 'should return a player as best player when tied for best' do
    game = create_game
    winning_player1 = create_player
    winning_player2 = create_player

    create_session(game, winning_players: [winning_player1])
    create_session(game, winning_players: [winning_player2])

    assert_includes [winning_player1, winning_player2], game.best_player.player
  end

  test 'should return a player as worst player when tied for worst' do
    game = create_game
    winning_player = create_player('winner')
    losing_player1 = create_player('loser1')
    losing_player2 = create_player('loser2')

    create_session(game, winning_players: [winning_player], losing_players: [losing_player1, losing_player2])

    assert_includes [losing_player1, losing_player2], game.worst_player.player
  end

  test 'should return null as worst player when all players are tied for stats' do
    game = create_game
    player1 = create_player
    player2 = create_player('test2')

    create_session(game, winning_players: [player1])
    create_session(game, winning_players: [player2])

    assert_nil game.worst_player
  end
end