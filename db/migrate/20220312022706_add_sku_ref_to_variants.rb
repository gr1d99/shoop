class AddSkuRefToVariants < ActiveRecord::Migration[6.0]
  def change
    add_reference :variants, :sku, null: false, foreign_key: true
    remove_column :variants, :sku
  end
end
