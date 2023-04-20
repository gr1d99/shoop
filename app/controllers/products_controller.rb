# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate, only: %i[create]
  def show
    @product = Product.friendly.find(params[:id])

    render json: ProductSerializer.new(@product)
  end

  def index
    @products = Product.includes(:category, :images,
                                 :master, :brand).page(pagination_params[:page]).per(pagination_params[:limit])
    with_pagination_options(@products) do |options|
      render json: ProductSerializer.new(@products, options)
    end
  end

  def create
    @product = Product.new product_params

    if @product.valid?
      @product.save!
      render json: ProductSerializer.new(@product), status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:product).permit(:created_by)
  end

  def product_params
    params.require(:product)
          .permit(:name, :description, :brand_id, :category_id, :stock, master_attributes: {})
          .merge(created_by_id: current_user.id)
  end
end
