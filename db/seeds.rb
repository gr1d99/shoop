# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  ActiveRecord::Base.transaction do
    OrderItem.delete_all!
    Order.delete_all!

    CartItem.delete_all!
    Cart.delete_all!

    Variant.delete_all!
    Sku.delete_all!

    User.delete_all!
    Product.delete_all!
    Category.delete_all!
    Brand.delete_all!
    Order.delete_all!
    Town.destroy_all
    County.destroy_all

    user = User.create!(
      first_name: 'test',
      last_name: 'user',
      email: 'test@user.com',
      phone: '0717582057',
      password: 'testpassword'
    )

    10.times do
      Category.create name: Faker::Lorem.word
    end

    10.times do
      Brand.create name: Faker::Lorem.word
    end

    20.times do
      product = Product.new name: Faker::Lorem.word,
                            description: Faker::Lorem.sentence(word_count: 10),
                            created_by: user,
                            brand: Brand.all.sample,
                            category: Category.all.sample

      sku = Sku.new value: Faker::Internet.unique.password(min_length: 6, max_length: 8)
      master_variant = Variant.new stock: Faker::Number.number(digits: 2), product: product, sku: sku, is_master: true, price: (0...9999).to_a.sample
      product.master = master_variant

      product.save!
    end

    ['Pay on Delivery', 'Credit Card'].each do |payment_method|
      PaymentMethod.create name: payment_method.to_s, description: "For #{payment_method} orders"
    end

    counties = JSON.parse File.read('./db/data/ke/county_towns.json')
    counties.each_key do |county|
      county = County.create name: county

      counties[county.name].each do |town|
        Town.create name: town, county: county
      end
    end
  end
end
