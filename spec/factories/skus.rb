# frozen_string_literal: true

FactoryBot.define do
  factory :sku do
    sku_no { Faker::Name.unique(5).name }
  end
end
