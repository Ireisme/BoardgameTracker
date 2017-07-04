require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  should 'post create' do
    @new_player = {
        'name' => 'Test',
        'powers' => 'godmode'
    }

    post :create, {'player_id' => 1, 'player' => @new_player}
    assert_response :success
  end

  should 'not show unknown player in list of players' do
    get :list
    def json_response
      ActiveSupport::JSON.decode @response.body
    end
    assert_equal (Player.count - 1), json_response.count
  end

  should 'not show unknown user page' do
    assert_raises(ActionController::RoutingError) do
      get(:show, {'id' => players(:unknown).id})
    end
  end

  should 'show valid players' do
    get(:show, {'id' => players(:brian).id})
    assert_response :success
  end

end
