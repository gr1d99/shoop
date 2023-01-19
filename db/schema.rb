# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_19_042455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.jsonb "meta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.text "description", default: ""
    t.index ["deleted_at"], name: "index_brands_on_deleted_at"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "product_id", null: false
    t.bigint "sku_id", null: false
    t.decimal "amount", precision: 8, scale: 2
    t.integer "quantity", default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["deleted_at"], name: "index_cart_items_on_deleted_at"
    t.index ["product_id", "cart_id", "sku_id"], name: "index_items_on_product_id_and_cart_id_sku_id_and_deleted_at", unique: true, where: "(deleted_at IS NULL)"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
    t.index ["sku_id"], name: "index_cart_items_on_sku_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_carts_on_deleted_at"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.jsonb "meta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.text "description", default: ""
    t.index ["deleted_at"], name: "index_categories_on_deleted_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "images", force: :cascade do |t|
    t.jsonb "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "imageable_id"
    t.string "imageable_type"
    t.string "name"
    t.string "alt"
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "option_values", force: :cascade do |t|
    t.string "name"
    t.bigint "option_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "slug", null: false
    t.index ["deleted_at"], name: "index_option_values_on_deleted_at"
    t.index ["option_id"], name: "index_option_values_on_option_id"
  end

  create_table "option_values_variants", force: :cascade do |t|
    t.bigint "option_value_id", null: false
    t.bigint "variant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_value_id"], name: "index_option_values_variants_on_option_value_id"
    t.index ["variant_id"], name: "index_option_values_variants_on_variant_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "slug", null: false
    t.index ["deleted_at"], name: "index_options_on_deleted_at"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "cart_item_id", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_item_id"], name: "index_order_items_on_cart_item_id"
    t.index ["deleted_at"], name: "index_order_items_on_deleted_at"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["deleted_at"], name: "index_orders_on_deleted_at"
  end

  create_table "orders_payment_methods", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_orders_payment_methods_on_order_id"
    t.index ["payment_method_id"], name: "index_orders_payment_methods_on_payment_method_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments_payment_methods", force: :cascade do |t|
    t.bigint "payment_id", null: false
    t.bigint "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_payments_payment_methods_on_payment_id"
    t.index ["payment_method_id"], name: "index_payments_payment_methods_on_payment_method_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.jsonb "meta"
    t.bigint "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description", null: false
    t.bigint "brand_id", null: false
    t.bigint "category_id", null: false
    t.datetime "deleted_at"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["created_by_id"], name: "index_products_on_created_by_id"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
  end

  create_table "products_options", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "option_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option_id"], name: "index_products_options_on_option_id"
    t.index ["product_id"], name: "index_products_options_on_product_id"
  end

  create_table "skus", force: :cascade do |t|
    t.string "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_skus_on_deleted_at"
    t.index ["value"], name: "index_skus_on_value", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.boolean "is_master", default: false
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.datetime "deleted_at"
    t.string "slug", null: false
    t.bigint "sku_id", null: false
    t.integer "stock", default: 0
    t.index ["deleted_at"], name: "index_variants_on_deleted_at"
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["sku_id"], name: "index_variants_on_sku_id", unique: true
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "cart_items", "skus"
  add_foreign_key "carts", "users"
  add_foreign_key "option_values", "options"
  add_foreign_key "option_values_variants", "option_values"
  add_foreign_key "option_values_variants", "variants"
  add_foreign_key "order_items", "cart_items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders_payment_methods", "orders"
  add_foreign_key "orders_payment_methods", "payment_methods"
  add_foreign_key "payments_payment_methods", "payment_methods"
  add_foreign_key "payments_payment_methods", "payments"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products_options", "options"
  add_foreign_key "products_options", "products"
  add_foreign_key "variants", "products"
  add_foreign_key "variants", "skus"
end
