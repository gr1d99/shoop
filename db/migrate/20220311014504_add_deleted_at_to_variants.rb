class AddDeletedAtToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :deleted_at, :datetime
    add_index :variants, :deleted_at
  end
end
