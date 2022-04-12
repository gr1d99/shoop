class ChangeCreatedByFieldToCreatedById < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :created_by, :created_by_id
  end
end
