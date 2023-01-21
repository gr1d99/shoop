# frozen_string_literal: true

class County < ApplicationRecord
  has_many :towns, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
end
