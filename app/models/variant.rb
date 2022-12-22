# frozen_string_literal: true

class Variant < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :history

  delegate :name, to: :product

  acts_as_paranoid

  belongs_to :product
  belongs_to :sku

  has_many :option_values_variants, class_name: 'OptionValuesVariants', dependent: :destroy
  has_many :option_values, through: :option_values_variants

  validates_uniqueness_of :sku_id

  with_options presence: true do
    validates :price
  end
end
