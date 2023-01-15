# frozen_string_literal: true

class Cart < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, optional: false
  has_one :order, dependent: :destroy
  has_many :items,
           class_name: 'CartItem',
           dependent: :destroy,
           validate: true,
           inverse_of: :cart
end
