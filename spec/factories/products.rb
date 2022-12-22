# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence(word_count: 4) }
    meta { {} }
    created_by factory: :user
    brand
    category

    after(:create) do |product|
      variant = build(:master_variant)
      variant.product = product
      variant.save
    end

    trait :with_image do
      after(:create) do |product, _evaluator|
        create :image, name: Faker::Name.name, alt: Faker::Name.name, imageable_type: 'Product',
                       imageable_id: product.id
      end
    end
  end
end
