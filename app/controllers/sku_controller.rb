# frozen_string_literal: true

class SkuController < ApplicationController
  before_action :authenticate, only: %i[create]

  def index
    @skus = Sku.includes(:variant).page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options(@skus) do |options|
      render json: SkuSerializer.new(@skus, options), status: :ok
    end
  end

  def create
    @sku = Sku.new sku_params

    if @sku.valid?
      @sku.save!

      render json: SkuSerializer.new(@sku), status: :created
    else
      render json: @sku.errors, status: :unprocessable_entity
    end
  end

  private

  def filter_params
    params.permit(:page, :limit)
  end

  def sku_params
    params.require(:sku).permit(:value)
  end
end
