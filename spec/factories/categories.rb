FactoryBot.define do
  factory :category do
    name { Faker::Commerce.unique.department }
    meta { {} }
    products { [association(:product)] }
  end
end
