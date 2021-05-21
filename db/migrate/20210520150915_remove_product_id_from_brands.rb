class RemoveProductIdFromBrands < ActiveRecord::Migration[6.0]
  def change
    remove_column :brands, :product_id, :foreign_key
  end
end
