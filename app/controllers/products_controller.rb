# frozen_string_literal: true

class ProductsController < ApplicationController
  def show
    @product = Product.friendly.find(params[:id])

    render json: ProductSerializer.new(@product)
  end

  def index
    render json: ProductSerializer.new(Product.all)
  end

  def create
    @user = User.find product_params[:created_by]
    @product = Product.new product_params.except(:created_by).merge(created_by: @user)
    @sku = Sku.new(no: sku_params[:sku])
    @product.build_master sku: @sku

    if @product.valid?
      @product.save!
      render json: ProductSerializer.new(@product), status: :created
    else
      render jsonapi_errors: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :brand_id, :category_id, :created_by)
  end

  def product_master_variant_params
    params.require(:product).permit(:price)
  end

  def sku_params
    params.require(:product).permit(:sku)
  end
end
