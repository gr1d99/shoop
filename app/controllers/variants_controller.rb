# frozen_string_literal: true

class VariantsController < ApplicationController
  def index
    @variants = Variant.page(pagination_params[:page]).per(pagination_params[:limit])

    with_pagination_options(@variants) do |options|
      render json: VariantSerializer.new(@variants, options)
    end
  end
end
