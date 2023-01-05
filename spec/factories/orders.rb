# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    cart { nil }
  end
end
