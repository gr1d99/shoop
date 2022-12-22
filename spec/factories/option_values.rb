# frozen_string_literal: true

FactoryBot.define do
  factory :option_value do
    name { 'MyString' }
    option { nil }
  end
end
