# frozen_string_literal: true

class Sku < ApplicationRecord
  has_one :variant, dependent: :destroy

  validates :sku_no, presence: true
  validates_uniqueness_of :sku_no, { case_sensitive: true }
end
