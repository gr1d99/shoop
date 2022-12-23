# frozen_string_literal: true

class CartItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :cart, required: true, inverse_of: :items
  belongs_to :product, required: true, inverse_of: :cart_items
  belongs_to :sku, required: true, inverse_of: :cart_items

  validates :amount, presence: true
end
