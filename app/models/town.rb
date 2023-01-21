# frozen_string_literal: true

class Town < ApplicationRecord
  belongs_to :county
  has_many :shipping_addresses, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
end
