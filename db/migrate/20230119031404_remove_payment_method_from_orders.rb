class RemovePaymentMethodFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_reference :orders, :payment_method_id
  end
end
