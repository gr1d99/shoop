# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  user = User.create(
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
                          description: Faker::Lorem.sentence(4),
                          created_by: user,
                          brand: Brand.all.sample,
                          category: Category.all.sample

    sku = Sku.new value: Faker::Internet.unique.password(min_length: 6, max_length: 8)
    master_variant = Variant.new stock: Faker::Number.number(digits: 2), product: product, sku: sku, is_master: true
    product.master = master_variant

    product.save!
  end

  ['Pay on Delivery', 'Credit Card'].each do |payment_method|
    PaymentMethod.create name: payment_method.to_s, description: "For #{payment_method.to_s} orders"
  end
end
