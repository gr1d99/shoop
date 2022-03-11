FactoryBot.define do
  factory :variant do
    sku { "MyString" }
    is_master { false }
    price { "9.99" }
  end
end
