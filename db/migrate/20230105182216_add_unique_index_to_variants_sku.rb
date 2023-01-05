class AddUniqueIndexToVariantsSku < ActiveRecord::Migration[6.0]
  def change
    remove_index :variants, :sku_id
    add_index :variants, :sku_id, unique: true
  end
end
