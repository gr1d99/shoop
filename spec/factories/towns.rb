# frozen_string_literal: true

FactoryBot.define do
  factory :town do
    name { Faker::Address.city }
    county
  end
end
