class AddUniqueIndexesToUser < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :email

    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end
end
