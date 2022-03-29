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

ActiveRecord::Schema.define(version: 2022_03_15_134519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.jsonb "meta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_brands_on_deleted_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.jsonb "meta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
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

  create_table "products", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "images"
    t.jsonb "meta"
    t.bigint "created_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description", null: false
    t.bigint "brand_id", null: false
    t.bigint "category_id", null: false
    t.datetime "deleted_at"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["created_by"], name: "index_products_on_created_by"
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
    t.string "no", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["no"], name: "index_skus_on_no"
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
    t.index ["deleted_at"], name: "index_variants_on_deleted_at"
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["sku_id"], name: "index_variants_on_sku_id"
  end

  add_foreign_key "option_values", "options"
  add_foreign_key "option_values_variants", "option_values"
  add_foreign_key "option_values_variants", "variants"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products_options", "options"
  add_foreign_key "products_options", "products"
  add_foreign_key "variants", "products"
  add_foreign_key "variants", "skus"
end
