# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate

  def show
    @cart = Cart.where(user: current_user).find(params[:id])

    render json: CartSerializer.new(@cart)
  end

  def index
    @carts = Cart.where(user: current_user).page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options(@carts) do |options|
      render json: CartSerializer.new(@carts, options)
    end
  end

  def create
    if Cart.exists?(user: current_user)
      @cart = Cart.find_by(user: current_user)

      render json: CartSerializer.new(@cart), status: :ok and return
    else
      @cart = Cart.new(user: current_user)
      @cart.save!

      render json: CartSerializer.new(@cart), status: :created and return
    end
  end

  private

  def cart_params
    params.require(:cart).permit
  end
end
