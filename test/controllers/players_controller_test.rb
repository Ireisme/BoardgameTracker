require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test 'should not show unknown player in list of players' do
    get :list
    def json_response
      ActiveSupport::JSON.decode @response.body
    end
    assert_equal (Player.count - 1), json_response.count
  end

  test 'should not display unknown player in index of players' do
    get :index

    assert_equal (Player.count - 1), assigns(:players).count
  end

  test 'should not show unknown user page' do
    assert_raises(ActionController::RoutingError) do
      get(:show, {'id' => players(:unknown).id})
    end
  end

  test 'should show valid players' do
    get(:show, {'id' => players(:brian).id})
    assert_response :success
  end

end
