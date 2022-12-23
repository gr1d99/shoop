# frozen_string_literal: true

class Cart < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, required: true
  has_many :items,
           class_name: 'CartItem',
           foreign_key: :cart_id,
           dependent: :destroy,
           validate: true,
           inverse_of: :cart
end
