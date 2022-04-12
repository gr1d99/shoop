FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence(word_count: 4) }
    meta { {} }
    created_by factory: :user
    brand
    category

    trait :with_image do
      after(:create) do |product, evaluator|
        create :image, name: Faker::Name.name, alt: Faker::Name.name, imageable_type: 'Product', imageable_id: product.id
      end
    end
  end
end
