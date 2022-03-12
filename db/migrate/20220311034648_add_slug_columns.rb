class AddSlugColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :slug, :string, null: false
    add_column :option_values, :slug, :string, null: false
    add_column :variants, :slug, :string, null: false
  end
end
