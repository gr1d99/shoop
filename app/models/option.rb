class Option < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :history

  acts_as_paranoid

  has_many :products_options, class_name: 'ProductsOptions', dependent: :destroy
  has_many :products, through: :products_options

  has_many :option_values, dependent: :destroy

  validates :name, presence: true
end
