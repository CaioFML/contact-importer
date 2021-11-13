class AddUniqueIndexToContact < ActiveRecord::Migration[6.1]
  def change
    add_index :contacts, :email, unique: true
  end
end
