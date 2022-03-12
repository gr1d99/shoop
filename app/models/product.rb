class Product < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  acts_as_paranoid

  belongs_to :created_by, class_name: 'User', foreign_key: :created_by, required: true

  belongs_to :brand, required: true

  belongs_to :category, required: true

  has_many :products_options, class_name: 'ProductsOptions', dependent: :destroy
  has_many :options, through: :products_options

  has_one :master, -> { where is_master: true }, class_name: 'Variant', dependent: :destroy, validate: true
  has_many :variants, -> { where is_master: false }, class_name: 'Variant', dependent: :destroy

  with_options presence: true do
    validates :name
    validates :description
  end
end
