# frozen_string_literal: true

class ProductsOptions < ApplicationRecord
  belongs_to :product
  belongs_to :option
end
