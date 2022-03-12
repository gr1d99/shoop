class AddProductIdToOptions < ActiveRecord::Migration[6.0]
  def change
    add_reference :options, :product, null: false, foreign_key: true
  end
end
