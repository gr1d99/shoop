# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate
  before_action :ensure_cart_owner!

  def show
    @cart_item = @cart.items.find(params[:id])

    render json: CartItemSerializer.new(@cart_item), status: :ok
  end

  def index
    @cart_items = @cart.items.page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options(@cart_items) do |options|
      render json: CartItemSerializer.new(@cart_items, options)
    end
  end

  def create
    @cart_item = @cart.items.build(cart_item_params)

    if @cart_item.valid?
      @cart_item.save!
      render json: CartItemSerializer.new(@cart_item), status: :created
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  def update
    @cart_item = @cart.items.find(params[:id])

    if @cart_item.update cart_item_params
      render json: CartItemSerializer.new(@cart_item)
    else
      render jsonapi_errors: @cart_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item = @cart.items.find(params[:id])

    @cart_item.destroy

    head :no_content
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :amount, :sku_id, :quantity)
  end
end
