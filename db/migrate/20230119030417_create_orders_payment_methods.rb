class CreateOrdersPaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_payment_methods do |t|
      t.bigint :order_id
      t.bigint :payment_method_id

      t.timestamps
    end
  end
end
