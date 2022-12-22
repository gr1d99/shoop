class AddDescriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :description, :text, :default => ''
    add_column :brands, :description, :text, :default => ''
  end
end
