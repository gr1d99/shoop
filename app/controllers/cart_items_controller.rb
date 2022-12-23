class CartItemsController < ApplicationController
  before_action :authenticate

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
end
