FactoryBot.define do
  factory :shipping_address do
    first_name { "MyString" }
    last_name { "MyString" }
    phone { "MyString" }
    county { nil }
    town { nil }
    description { "MyText" }
    is_default { false }
  end
end
