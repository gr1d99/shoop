# frozen_string_literal: true

class Sku < ApplicationRecord
  acts_as_paranoid

  has_one :variant, dependent: :destroy, validate: true
  has_many :cart_items, dependent: :destroy, validate: true, inverse_of: :sku

  validates :sku_no, presence: true
  validates :sku_no, uniqueness: { case_sensitive: true }
end
