class AddUniqueIndexToCartItem < ActiveRecord::Migration[6.0]
  def change
    add_index :cart_items, [:product_id, :cart_id, :sku_id],
              unique: true,
              name: :index_items_on_product_id_and_cart_id_sku_id_and_deleted_at,
              where: "cart_items.deleted_at IS NULL"
  end
end
