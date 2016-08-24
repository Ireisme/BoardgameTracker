require 'test_helper'

class PlayerStatisticsRequestTest < ActionDispatch::IntegrationTest
  include PlayerCreation

  test 'gets existing player statistics' do
    player = create_player

    get "/players/#{player.id}/statistics"

    assert_response :success
    result = JSON.parse(response.body)
    assert_equal player.id, result['player_id']
    assert_equal 0, result['session_count']
  end

  test 'returns not found when searching for invalid player' do
    invalid_player = 999

    assert_raise ActionController::RoutingError do
      get "/players/#{invalid_player}/statistics"
    end
  end
end