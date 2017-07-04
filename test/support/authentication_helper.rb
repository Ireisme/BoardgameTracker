require 'helpers/fixture_helpers'

module SessionHelper
  include FixtureHelpers

  def retrieve_access_headers
    user = users(:user1)
    params = {:email => user.email, :password => default_password}

    post "/auth/sign_in", params, format: :json

    access_headers = {"access-token" => response.headers["access-token"],
                      "client" => response.headers["client"],
                      "expiry" => response.headers["expiry"],
                      "uid" => response.headers["uid"],
                      "token-type" => response.headers["token-type"],
                      'HTTP_ACCEPT' => "application/json"
    }

    return access_headers
  end
end