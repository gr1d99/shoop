class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: :true

  has_many :categorization, class_name: 'CategoryProduct'
  has_many :products, through: :categorization, class_name: 'CategoryProduct'
end
