class OptionValue < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  acts_as_paranoid

  belongs_to :option

  has_many :option_values_variants, class_name: 'OptionValuesVariants', dependent: :destroy
  has_many :variants, through: :option_values_variants

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :option_id, case_sensitive: true
end
