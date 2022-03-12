class AddDeletedAtToOptionValues < ActiveRecord::Migration[6.0]
  def change
    add_column :option_values, :deleted_at, :datetime
    add_index :option_values, :deleted_at
  end
end
