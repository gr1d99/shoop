# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    transient do
      variant_option_values { nil }
    end
    transient do
      stock { 0 }
    end

    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence(word_count: 4) }
    meta { {} }
    created_by factory: :user
    brand
    category

    trait :with_master do
      after(:create) do |product, evaluator|
        variant = build(:master_variant)
        variant.product = product
        variant.stock = evaluator.stock
        variant.save
      end
    end

    trait :with_variant do
      after(:create) do |product, evaluator|
        create :variant, product: product, option_values: evaluator.variant_option_values
      end
    end

    trait :with_image do
      after(:create) do |product, _evaluator|
        create :image, name: Faker::Name.name, alt: Faker::Name.name, imageable_type: 'Product',
                       imageable_id: product.id
      end
    end
  end
end
