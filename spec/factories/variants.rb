# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    sku
    is_master { false }
    price { '9.99' }

    factory :master_variant do
      is_master { true }
    end
  end
end
