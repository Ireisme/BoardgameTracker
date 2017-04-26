class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include DeviseTokenAuth::Concerns::SetUserByToken

  # protect_from_forgery with: :null_session
  respond_to :html, :json

  def not_found
     raise ActionController::RoutingError.new('Not Found')
  end
end
