# frozen_string_literal: true

class Product < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  acts_as_paranoid

  belongs_to :created_by, class_name: 'User', optional: false, inverse_of: :products

  belongs_to :brand, optional: false

  belongs_to :category, optional: false

  has_many :products_options, class_name: 'ProductsOptions', dependent: :destroy
  has_many :options, through: :products_options
  has_many :cart_items, dependent: :destroy, inverse_of: :product

  has_one :master,
          -> { where(is_master: true) },
          class_name: 'Variant',
          dependent: :destroy,
          inverse_of: :product,
          validate: true
  has_many :variants,
           -> { where is_master: false },
           class_name: 'Variant',
           dependent: :destroy,
           validate: true

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :master

  with_options presence: true do
    validates :name
    validates :description
  end

  delegate :price, to: :master
end
