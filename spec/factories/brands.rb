FactoryBot.define do
  factory :brand do
    name { Faker::Commerce.unique.material }
    meta { {} }

    factory :brand_with_products do
      products { [association(:product)] }
    end
  end
end
