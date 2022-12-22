# frozen_string_literal: true

class BrandsController < ApplicationController
  def show
    @brand = Brand.friendly.find(params[:id])

    render json: BrandSerializer.new(@brand)
  end

  def index
    @brands = Brand.page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options(@brands) do |options|
      render json: BrandSerializer.new(@brands, options)
    end
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      render json: @brand, status: :created
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :slug)
  end
end
