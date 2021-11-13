class CreateContactFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.text :log

      t.timestamps
    end
  end
end
