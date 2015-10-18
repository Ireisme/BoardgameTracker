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

  test 'should get index' do
    get :index
    assert_response :success
  end
end
