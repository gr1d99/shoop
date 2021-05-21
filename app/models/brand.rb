class Brand < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :products

  with_options presence: true do
    validates :name, uniqueness: :true
  end
end
