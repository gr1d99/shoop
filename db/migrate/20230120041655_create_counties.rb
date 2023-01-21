class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
