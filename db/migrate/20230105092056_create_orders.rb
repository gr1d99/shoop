class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :cart, null: false, foreign_key: true
      t.datetime :deleted_at, null: true

      t.timestamps

      t.index :deleted_at
    end
  end
end
