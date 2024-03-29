class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true

      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end
  end
end
