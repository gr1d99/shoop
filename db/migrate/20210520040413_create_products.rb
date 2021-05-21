class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :slug
      t.string :name
      t.string :images
      t.decimal :price, precision: 6, scale: 2
      t.jsonb :meta
      t.bigint :created_by, foreign_key: true, index: true

      t.timestamps
    end
  end
end
