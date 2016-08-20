require 'test_helper'

class SessionStatsTest < ActiveSupport::TestCase
  include GameCreation, PlayerCreation, SessionCreation

  context 'session_count' do
    should 'return number of sessions played' do
      player = create_player
      create_session(create_game, winning_players: [player])

      session_count = PlayerStatistic.new(player.id).session_count

      assert_equal 1, session_count
    end

    should 'count sessions with duplicate player once' do
      player = create_player
      create_session(create_game, winning_players: [player, player])

      session_count = PlayerStatistic.new(player.id).session_count

      assert_equal 1, session_count
    end
  end

  context 'most played game' do
    should 'return nil when no games played' do
      player = create_player

      most_played_game = PlayerStatistic.new(player.id).most_played_game

      assert_nil most_played_game
    end

    should 'calculate based upon most sessions played' do
      player = create_player
      game_one = create_game('mostPlayed')
      game_two = create_game
      2.times { create_session(game_one, winning_players: [player]) }
      create_session(game_two, winning_players: [player])

      most_played_game = PlayerStatistic.new(player.id).most_played_game

      assert_equal game_one, most_played_game
    end

    should 'count sessions with duplicate players once' do
      player = create_player
      game_one = create_game('mostPlayed')
      game_two = create_game
      3.times { create_session(game_one, winning_players:[player]) }
      2.times { create_session(game_two, winning_players:[player, player]) }

      most_played_game = PlayerStatistic.new(player.id).most_played_game

      assert_equal game_one, most_played_game
    end
  end
end