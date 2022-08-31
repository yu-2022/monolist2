class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.text :item_text
      t.date :item_date
      t.references :user, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
