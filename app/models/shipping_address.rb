# frozen_string_literal: true

class ShippingAddress < ApplicationRecord
  belongs_to :town
  belongs_to :user
  has_many :orders, dependent: :restrict_with_error

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :phone
    validates :description
  end
end
