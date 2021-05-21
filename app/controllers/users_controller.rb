class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def update
    @user = User.find(params[:id])


    if @user.update(user_params)
      render json: @user
    end

    render json: @user.errors
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone)
  end
end
