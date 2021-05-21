FactoryBot.define do
  factory :brand do
    name { Faker::Name.unique.name }
    meta { {} }

    factory :brand_with_products do
      products { [association(:product)] }
    end
  end
end
