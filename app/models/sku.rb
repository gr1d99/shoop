# frozen_string_literal: true

class Sku < ApplicationRecord
  has_one :variant, dependent: :destroy

  validates_uniqueness_of :no, { case_sensitive: true }
end
