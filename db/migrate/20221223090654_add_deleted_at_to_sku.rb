class AddDeletedAtToSku < ActiveRecord::Migration[6.0]
  def change
    add_column :skus, :deleted_at, :datetime
    add_index :skus, :deleted_at
  end
end
