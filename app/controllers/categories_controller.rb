class CategoriesController < ApplicationController
  def index
    @categories = Category.all

    render json: CategorySerializer.new(@categories)
  end

  def create
    @category = Category.new category_params

    if @category.valid?
      @category.save!

      render json: CategorySerializer.new(@category), status: :created
    else
      render jsonapi_errors: @category.errors, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
