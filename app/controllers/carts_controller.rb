# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate
  def create
    status = :created

    if Cart.exists?(user: current_user)
      @cart = Cart.find_by(user: current_user)
      status = :ok
    else
      @cart = Cart.new(user: current_user)
      @cart.save!
    end

    render json: CartSerializer.new(@cart), status: status
  end

  private

  def cart_params
    params.require(:cart).permit
  end
end
