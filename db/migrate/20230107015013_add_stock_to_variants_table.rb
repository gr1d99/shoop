class AddStockToVariantsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :stock, :integer, default: 0
  end
end
