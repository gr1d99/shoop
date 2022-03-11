class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.string :sku
      t.boolean :is_master, default: false
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
