FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    images { "" }
    price { Faker::Commerce.price }
    description { Faker::Lorem.sentence(word_count: 4) }
    meta { {} }
    user factory: :user
    brand
    category { [association(:category)] }
  end
end
