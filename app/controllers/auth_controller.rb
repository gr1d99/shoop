# frozen_string_literal: true

class AuthController < ApplicationController
  def create
    @user = User.find_by(email: create_params[:email])

    if @user&.authenticate(create_params[:password])
      render json: { token: @user.generate_jwt }
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def create_params
    params.require(:auth).permit(:email, :password)
  end
end
