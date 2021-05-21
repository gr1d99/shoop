class CreateCategoryProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :categorization do |t|
      t.references :category, null: true
      t.references :product, null: true

      t.timestamps
    end
  end
end
