# frozen_string_literal: true

class CartItem < ApplicationRecord
  acts_as_paranoid
  validates_as_paranoid

  belongs_to :cart, optional: false, inverse_of: :items
  belongs_to :product, optional: false, inverse_of: :cart_items
  belongs_to :sku, optional: false, inverse_of: :cart_items

  validates :amount, presence: true
  validates_uniqueness_of_without_deleted :product_id,
                                          scope: %i[cart_id sku_id deleted_at],
                                          message: :taken
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, in_stock: true, if: proc { |item| item.sku.present? }
end
