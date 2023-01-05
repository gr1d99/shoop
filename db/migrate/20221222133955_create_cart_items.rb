# frozen_string_literal: true
class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :sku, { null: false , foreign_key: true }
      t.decimal :amount, precision: 8, scale: 2
      t.integer :quantity, default: 1

      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end
  end
end
