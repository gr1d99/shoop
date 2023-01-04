# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate

  def index
    @cart = Cart.find(params[:cart_id])

    if @cart.user.id != current_user.id
      render json: { message: 'Cart not found' }, status: :not_found
    else
      @cart_items = @cart.items

      render json: @cart_items
    end
  end

  def create
    @cart = Cart.find(params[:cart_id])
    @cart_item = @cart.items.build(cart_item_params)

    if @cart_item.valid?
      @cart_item.save!
      render json: CartItemSerializer.new(@cart_item), status: :created
    else
      render jsonapi_errors: @cart_item.errors, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :amount, :sku_id, :quantity)
  end

  def item_q_params
    cart_item_params.except(:amount, :quantity)
  end
end
