FactoryBot.define do
  factory :order_item do
    order { nil }
    cart_item { nil }
    amount { nil }
  end
end
