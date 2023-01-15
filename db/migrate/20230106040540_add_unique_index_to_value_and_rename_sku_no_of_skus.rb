class AddUniqueIndexToValueAndRenameSkuNoOfSkus < ActiveRecord::Migration[6.0]
  def change
    remove_index :skus, :sku_no
    rename_column :skus, :sku_no, :value
    add_index :skus, :value, unique: true
  end
end
