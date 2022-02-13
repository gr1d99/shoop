class CreateJoinTableCategoryProduct < ActiveRecord::Migration[6.0]
  def change
    create_join_table :categories, :products do |t|
      t.index %i[category_id product_id]
      t.index %i[product_id category_id]
    end
  end
end
