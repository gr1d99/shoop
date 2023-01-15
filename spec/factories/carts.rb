# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    user

    transient do
      items_count { 1 }
    end

    transient do
      items_stock { 1 }
    end

    trait :with_items do
      after(:create) do |cart, evaluator|
        products = create_list(:product, evaluator.items_count, :with_master, stock: evaluator.items_stock)
        products.each do |product|
          create(:cart_item, cart: cart, product: product, sku: product.master.sku)
        end
      end
    end
  end
end
