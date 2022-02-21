class Product < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :created_by, class_name: 'User', foreign_key: :created_by, required: true
  belongs_to :brand, required: true
  belongs_to :category, required: true

  with_options presence: true do
    validates :name
    validates :price
    validates :description
  end
end
