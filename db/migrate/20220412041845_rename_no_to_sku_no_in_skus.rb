class RenameNoToSkuNoInSkus < ActiveRecord::Migration[6.0]
  def change
    rename_column :skus, :no, :sku_no
  end
end
