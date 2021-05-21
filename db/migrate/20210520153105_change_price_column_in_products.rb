class ChangePriceColumnInProducts < ActiveRecord::Migration[6.0]
  def up
    change_column :products, :price, :decimal, precision: 8, scale: 2
  end

  def down
    change_column :products, :price, :decimal, precision: 6, scale: 2
  end
end
