# frozen_string_literal: true

class LoginService < BaseService
  def call
    @user = User.find_by(email: params[:email])
    result.user = @user

    result.success = if @user&.authenticate(params[:password])
                       OnboardService.call({ user: @user })
                     else
                       false
                     end

    result
  end
end
