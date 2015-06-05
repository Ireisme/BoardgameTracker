require 'test_helper'

class Game::SessionsControllerTest < ActionController::TestCase
  test 'should post create' do
    @session_players = [
        {
            'player_id' => 1,
            'placing' => 1,
            'score' => 1
        }
    ]

    post :create, {'game_id' => 1, 'session_players' => @session_players}
    assert_response :success
  end

  # TODO Add this back when show is available
  # test 'should get show' do
  #   get(:show, {'id' => '1'})
  #   assert_response :success
  # end

  test 'should get index' do
    get :index
    assert_response :success
  end

end
