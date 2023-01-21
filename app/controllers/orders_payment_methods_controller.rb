# frozen_string_literal: true

class OrdersPaymentMethodsController < ApplicationController
  before_action :authenticate
  before_action :ensure_order_owner!

  def create
    @order_payment_method = @order.build_orders_payment_methods create_params

    if @order_payment_method.valid?
      @order_payment_method.save!

      render json: @order_payment_method, status: :created
    else
      render json: @order_payment_method.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:order_payment_method).permit(:payment_method_id)
  end
end
