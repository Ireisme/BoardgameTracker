require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  should 'post create' do
    new_game = {
        'name' => 'test',
        'description' => 'test desc',
        'game_type' => Game.game_types[:mixed]
    }

    post :create, {'game_id' => 1, 'game' => new_game}
    assert_response :success
  end

  should 'get list' do
    get :list
    assert_response :success
    assert_equal 2, JSON.parse(response.body).size
  end

  should 'get individual game from view' do
    game = Game.find(ActiveRecord::FixtureSet.identify(:game_one))

    get :show, id: game.id, :format => "json"
    assert_response :success
    result = JSON.parse(response.body)
    assert_equal game.name, result["name"]
  end

  should 'have no stats on new game' do
    new_game = {
        'name' => 'test',
        'description' => 'test desc',
        'game_type' => Game.game_types[:mixed]
    }
    post :create, {'game_id' => 1, 'game' => new_game}

    get :show, id: response.body, :format => "json"

    parsed_game = JSON.parse(response.body)
    assert_nil parsed_game[:best_player]
    assert_nil parsed_game[:worst_player]
  end
end
