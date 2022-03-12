class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  acts_as_paranoid

  validates :name, presence: true, uniqueness: :true

  has_many :products
end
