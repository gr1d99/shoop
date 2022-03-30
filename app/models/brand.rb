# frozen_string_literal: true

class Brand < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :history

  acts_as_paranoid

  has_many :products

  with_options presence: true do
    validates :name, uniqueness: true
  end
end
