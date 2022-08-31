class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :list_name,   null: false
      t.text :list_text
      t.integer :privacy_id, null: false
      t.references :user,    null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
