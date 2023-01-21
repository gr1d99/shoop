# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :authenticate

  def create
    @order = Order.find params[:order_id]
    @payment = @order.build_payment create_params

    if @payment.valid?
      @payment.save!
      @order.reload
      @order.process_payment!

      render json: PaymentSerializer.new(@payment), status: :created

    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:payment).permit(:amount)
  end
end
