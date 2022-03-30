class AddImageableToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :imageable_id, :bigint
    add_column :images, :imageable_type, :string

    add_index :images, [:imageable_type, :imageable_id]
  end
end
