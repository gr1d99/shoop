# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate, only: %i[create]
  include PaginationConcern
  def show
    @product = Product.friendly.find(params[:id])

    render json: ProductSerializer.new(@product)
  end

  def index
    @products = Product.includes(:images, :master).page(pagination_params[:page]).per(pagination_params[:limit])
    pagination_options(@products) do |options|
      render json: ProductSerializer.new(@products, options)
    end
  end

  def create
    @product = Product.new product_params.merge(created_by_id: current_user.id)
    @sku = Sku.new sku_params

    if @sku.valid?
      @sku.save!
      @product.build_master master_variant_params.merge(sku: @sku)
      if @product.valid? && @sku.valid?
        @product.save!
        render json: ProductSerializer.new(@product), status: :created
      else
        render jsonapi_errors: @product.errors, status: :unprocessable_entity
      end
    else
      render jsonapi_errors: @sku.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:product).permit(:created_by)
  end

  def product_params
    params.require(:product).permit(:name, :description, :brand_id, :category_id)
  end

  def master_variant_params
    params.require(:product).permit(:price)
  end

  def sku_params
    params.require(:product).permit(:sku_no)
  end
end
