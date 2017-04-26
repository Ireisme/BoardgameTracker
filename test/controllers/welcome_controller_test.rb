require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  should "should get index" do
    get :index
    assert_response :success
  end

end
