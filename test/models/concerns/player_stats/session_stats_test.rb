require 'test_helper'

class SessionStatsTest < ActionController::TestCase
  include GameCreation, PlayerCreation, SessionCreation

  test 'should return number of sessions played' do
    player = create_player
    create_session(create_game, winning_players: [player])

    session_count = PlayerStatistic.new(player.id).session_count

    assert_equal 1, session_count
  end

  test 'should count sessions with duplicate player once' do
    player = create_player
    create_session(create_game, winning_players: [player, player])

    session_count = PlayerStatistic.new(player.id).session_count

    assert_equal 1, session_count
  end
end