# frozen_string_literal: true

FactoryBot.define do
  factory :payment_method do
    name { 'MyString' }
    description { 'MyText' }

    trait :pay_on_delivery do
      before :create do |payment_method, _evaluator|
        payment_method.name = 'Pay on Delivery'
      end
    end
  end
end
