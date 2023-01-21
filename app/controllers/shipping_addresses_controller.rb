# frozen_string_literal: true

class ShippingAddressesController < ApplicationController
  before_action :authenticate

  def index
    @shipping_addresses = ShippingAddress.page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options @shipping_addresses do |options|
      render json: ShippingAddressSerializer.new(@shipping_addresses, options)
    end
  end

  def show
    @shipping_address = ShippingAddress.find params[:id]

    render json: ShippingAddressSerializer.new(@shipping_address)
  end

  def create
    @user = User.find(params[:user_id])
    @shipping_address = @user.shipping_addresses.build create_params

    if @shipping_address.valid?
      @shipping_address.save!

      render json: ShippingAddressSerializer.new(@shipping_address), status: :created
    else
      render json: @shipping_address.errors, status: :unprocessable_entity
    end
  end

  def update
    @shipping_address = ShippingAddress.find params[:id]

    if @shipping_address.update create_params
      render json: ShippingAddressSerializer.new(@shipping_address), status: :ok
    else
      render json: @shipping_address.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:shipping_address).permit(:first_name, :last_name, :phone, :description, :town_id)
  end
end
