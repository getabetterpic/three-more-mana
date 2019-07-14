class SessionsController < ApplicationController
  def create
    user = User.authenticate(params.dig(:user, :email), params.dig(:user, :password))
    if user
      data = {
        token: user.access_token,
        email: user.email
      }
      render json: data, status: :created
    else
      render json: { error: 'Email or password invalid' }, status: :unauthorized
    end
  end
end
