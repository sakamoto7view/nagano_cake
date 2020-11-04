class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :genre_id
      t.text :introduction
      t.integer :price
      t.boolean :is_active
      t.timestamps
    end
  end
end
