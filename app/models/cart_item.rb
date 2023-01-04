# frozen_string_literal: true

class CartItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :cart, optional: false, inverse_of: :items
  belongs_to :product, optional: false, inverse_of: :cart_items
  belongs_to :sku, optional: false, inverse_of: :cart_items

  validates :amount, presence: true
  validates :product_id, uniqueness: { scope: %i[sku_id cart_id], message: 'item already exist in cart' }
end
