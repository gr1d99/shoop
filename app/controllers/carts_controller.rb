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

  def filter_params
    params.permit(:page, :limit)
  end

  def cart_params
    params.require(:cart).permit
  end
end
