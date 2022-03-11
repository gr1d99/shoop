class Variant < ApplicationRecord
  acts_as_paranoid

  belongs_to :product

  has_many :option_values_variants, class_name: 'OptionValuesVariants', dependent: :destroy
  has_many :option_values, through: :option_values_variants
end
