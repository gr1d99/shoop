class AddImageNameAndAltToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :name, :string
    add_column :images, :alt, :string
  end
end
