class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.jsonb :meta

      t.timestamps
    end
  end
end
