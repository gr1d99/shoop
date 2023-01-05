# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    cart
    product { nil }
    quantity { 1 }
    amount { Faker::Number.unique.number digits: 3 }
    sku { nil }
  end
end
