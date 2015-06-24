require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
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
