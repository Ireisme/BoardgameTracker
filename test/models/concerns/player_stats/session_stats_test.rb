require 'test_helper'

class SessionStatsTest < ActionController::TestCase
  test 'should return number of sessions played' do
    player = create_player
    create_session(create_game, player)

    session_count = PlayerStatistic.new(player.id).session_count

    assert_equal 1, session_count
  end

  test 'should count sessions with duplicate player once' do
    player = create_player
    create_session(create_game, player, player)

    session_count = PlayerStatistic.new(player.id).session_count

    assert_equal 1, session_count
  end

  private
    def create_player(name = 'test')
      player = Player.new(:name => name)
      player.save
      return player
    end

    def create_game
      game = Game.new(:name => 'test', :game_type => Game.game_types[:mixed])
      game.save
      return game
    end

    def create_session(game, *players)
      session = Session.new(:game_id => game.id)
      session.save

      players.each do |player|
        session_player2 = SessionPlayer.new(:session_id => session.id, :player_id => player.id)
        session_player2.placing = 2
        session_player2.save
      end
    end
end