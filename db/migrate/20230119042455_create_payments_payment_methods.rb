class CreatePaymentsPaymentMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :payments_payment_methods do |t|
      t.references :payment,  null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
