class RemoveProductIdFromOptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :options, :product_id
  end
end
