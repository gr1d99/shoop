# frozen_string_literal: true

FactoryBot.define do
  factory :sku do
    value { Faker::Name.unique(5).name }
  end
end
