class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :cart_item, null: false, foreign_key: true
      t.decimal :amount, null: false, precision: 8, scale: 2
      t.datetime :deleted_at, null: true

      t.timestamps

      t.index :deleted_at
    end
  end
end
