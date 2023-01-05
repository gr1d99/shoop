# frozen_string_literal: true

class Variant < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :history

  delegate :name, to: :product

  acts_as_paranoid

  belongs_to :product
  belongs_to :sku, validate: true

  has_many :option_values_variants, class_name: 'OptionValuesVariants', dependent: :destroy
  has_many :option_values, through: :option_values_variants

  validates :sku_id, uniqueness: true
end
