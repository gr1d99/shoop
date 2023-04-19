# frozen_string_literal: true

class AuthController < ApplicationController
  def create
    result = LoginService.call create_params

    if result.success
      render json: { token: result.user.generate_jwt }
    else
      render json: { message: 'Incorrect email or password' }, status: :unauthorized
    end
  end

  private

  def create_params
    params.require(:auth).permit(:email, :password)
  end
end
