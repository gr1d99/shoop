# frozen_string_literal: true

class Order < ApplicationRecord
  acts_as_paranoid

  belongs_to :cart
  has_many :items, class_name: 'OrderItem', dependent: :destroy

  validates :cart, cart_items: true

  private

  def cart_items
    cart.items.length
  end
end
