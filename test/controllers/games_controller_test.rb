require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test 'should post create' do
    @new_game = {
        'name' => 'test',
        'description' => 'test desc'
    }

    post :create, {'game_id' => 1, 'game' => @new_game}
    assert_response :success
  end

  test 'should get list' do
    get :list
    assert_response :success
    assert_equal 2, JSON.parse(response.body).size
  end

  test 'should get individual game from view' do
    @game = Game.find(ActiveRecord::FixtureSet.identify(:game_one))

    get :view, id: @game.id, :format => "json"
    assert_response :success
    result = JSON.parse(response.body)
    assert_equal @game.name, result["name"]
  end
end
