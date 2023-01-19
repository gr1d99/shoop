# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate
  before_action :ensure_cart_owner!, only: %i[create]
  before_action :ensure_order_owner!, only: %i[show update]

  def show
    render json: OrderSerializer.new(@order), status: :ok
  end

  def create
    @order = @cart.build_order
    @order.payment_method = PaymentMethod.find_by id: create_params[:payment_method_id]
    order_item_attrs = @order.cart.items.select('id as cart_item_id, amount').map(&:attributes)
    @order.items.build order_item_attrs

    if @order.valid?
      @order.save!
      render json: OrderSerializer.new(@order), status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update!
      render json: OrderSerializer.new(@order), status: :ok
    else
      render @order.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:order).permit(:payment_method_id, :status).except(:status)
  end

  def ensure_order_owner!
    @order = @current_user.orders.find(params[:id])
  end
end
