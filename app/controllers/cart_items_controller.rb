# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate
  before_action :set_cart
  before_action :ensure_cart_owner!
  before_action :set_cart_item, only: %i[show update destroy]

  def show
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
      render jsonapi_errors: @cart_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @cart_item.update cart_item_params
      render json: CartItemSerializer.new(@cart_item)
    else
      render jsonapi_errors: @cart_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item.destroy

    head :no_content
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :amount, :sku_id, :quantity)
  end

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def set_cart_item
    @cart_item = @cart.items.find(params[:id])
  end

  def ensure_cart_owner!
    return unless @cart.user != current_user

    render json: { message: 'Cart not found' }, status: :not_found
  end
end
