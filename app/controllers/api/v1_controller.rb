class Api::V1Controller < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(email: options[:email], access_token: token)
    end
  end

  def current_user
    @current_user
  end
end
