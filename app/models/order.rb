class Order < ApplicationRecord
  acts_as_paranoid

  belongs_to :cart
  has_many :order_items, dependent: :destroy
end
