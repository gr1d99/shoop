class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.jsonb :image_data

      t.timestamps
    end
  end
end
