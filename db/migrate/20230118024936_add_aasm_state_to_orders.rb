class AddAasmStateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :aasm_state, :string
  end
end
