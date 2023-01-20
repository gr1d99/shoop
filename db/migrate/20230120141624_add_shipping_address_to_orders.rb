class AddShippingAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :shipping_address, null: false, foreign_key: true
  end
end
