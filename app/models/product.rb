class Product < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :created_by, class_name: 'User', foreign_key: :created_by, required: true
  belongs_to :brand, required: true

  has_one :categorization, class_name: 'CategoryProduct'
  has_one :category, through: :categorization, class_name: 'CategoryProduct', required: true

  with_options presence: true do
    validates :name
    validates :price
    validates :description
  end
end
