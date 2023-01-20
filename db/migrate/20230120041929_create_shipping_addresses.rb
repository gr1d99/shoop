class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.references :county, null: false, foreign_key: true
      t.references :town, null: false, foreign_key: true
      t.text :description
      t.boolean :is_default

      t.timestamps
    end
  end
end
