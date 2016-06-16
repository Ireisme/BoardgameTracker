require 'test_helper'

class StatsRetrieverTest < ActionController::TestCase
  test 'should return a player as best player when tied for best' do
    game = create_game
    winning_player1 = create_player
    winning_player2 = create_player

    create_session(game, winning_player1)
    create_session(game, winning_player2)

    assert_includes [winning_player1, winning_player2], game.best_player.player
  end

  test 'should return null as worst player when all players are tied for stats' do
    game = create_game
    player1 = create_player
    player2 = create_player('test2')

    create_session(game, player1)
    create_session(game, player2)

    assert_nil game.worst_player
  end

  private
    def create_game
      game = Game.new(:name => 'test', :game_type => Game.game_types[:mixed])
      game.save
      return game
    end

    def create_player(name = 'test')
      player = Player.new(:name => name)
      player.save
      return player
    end

  def create_session(game, winning_player, *losing_players)
    session = Session.new(:game_id => game.id)
    session.save

    session_player = SessionPlayer.new(:session_id => session.id, :player_id => winning_player.id)
    session_player.placing = 1
    session_player.save

    return if losing_players.empty?

    losing_players.each do |loser|
      session_player2 = SessionPlayer.new(:session_id => session.id, :player_id => loser.id)
      session_player2.placing = 2
      session_player2.save
    end
  end
end