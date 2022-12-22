class CartItem < ApplicationRecord
  acts_as_paranoid

  belongs_to :cart, required: true, inverse_of: :items
  belongs_to :product, required: true, inverse_of: :cart_items
end
