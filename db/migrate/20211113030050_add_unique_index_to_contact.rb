class AddUniqueIndexToContact < ActiveRecord::Migration[6.1]
  def change
    add_index :contacts, [:email, :user_id], unique: true
  end
end
