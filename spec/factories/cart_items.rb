FactoryBot.define do
  factory :cart_item do
    cart { nil }
    product { nil }
    price { "9.99" }
    quantity { 1 }
  end
end
