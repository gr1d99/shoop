# frozen_string_literal: true

class OnboardService < BaseService
  def call
    create_cart
  end

  private

  def create_cart
    user = params[:user]

    user.carts.create! if user.carts.empty?
    user.reload

    result
  end
end
