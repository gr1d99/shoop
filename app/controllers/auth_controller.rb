class AuthController < ApplicationController
  def create
    @user = User.find_by_email(create_params[:email]).authenticate(create_params[:password])

    if @user
      render json: { token: @user.generate_jwt }
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def create_params
    params.require(:auth).permit(:email, :password)
  end
end
