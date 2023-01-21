# frozen_string_literal: true

class PaymentMethodsController < ApplicationController
  def index
    @payment_methods = PaymentMethod.page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options @payment_methods do |options|
      render json: PaymentMethodSerializer.new(@payment_methods, options), status: :ok
    end
  end
end
