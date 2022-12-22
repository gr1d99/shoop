# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate, only: %i[create]
  def show
    @product = Product.friendly.find(params[:id])

    render json: ProductSerializer.new(@product)
  end

  def index
    render json: ProductSerializer.new(Product.includes(:images, :master).all)
  end

  def create
    p current_user
    @product = Product.new product_params
    @sku = Sku.new sku_params
    if @sku.valid?
      @sku.save!
      @product.build_master master_variant_params.merge(sku: @sku)
      if @product.valid? && @sku.valid?
        @product.created_by_id = current_user.id
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
