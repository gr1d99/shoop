class ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def create
    @product = Product.new product_params

    @category = Category.find params[:product][:category_id]
    @user = User.find params[:product][:created_by]

    @product.category = @category
    @product.created_by = @user

    if @product.valid?
      @product.save!

      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :brand_id)
  end
end
