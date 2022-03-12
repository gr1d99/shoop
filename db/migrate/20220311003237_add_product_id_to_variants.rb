class AddProductIdToVariants < ActiveRecord::Migration[6.0]
  def change
    add_reference :variants, :product, null: false, foreign_key: true
  end
end
