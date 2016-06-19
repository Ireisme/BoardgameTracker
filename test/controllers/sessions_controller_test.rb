require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
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

  test 'should not be able to add player twice to session' do
    @session_players = [
        {
            'player_id' => players(:josh).id,
            'placing' => 1,
            'score' => 2
        },
        {
            'player_id' => players(:josh).id,
            'placing' => 2,
            'score' => 1
        }
    ]

    assert_raises(ActionController::BadRequest) do
      post :create, {'game_id' => 1, 'session_players' => @session_players}
    end
  end

  test 'should be able to add unknown player multiple times to session' do
    @session_players = [
        {
            'player_id' => players(:brian).id,
            'placing' => 2,
            'score' => 1
        },
        {
            'player_id' => players(:unknown).id,
            'placing' => 1,
            'score' => 2
        },
        {
            'player_id' => players(:unknown).id,
            'placing' => 2,
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

  test 'should get list' do
    get :list
    assert_response :success
  end

end
