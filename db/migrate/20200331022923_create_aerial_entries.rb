class CreateAerialEntries < ActiveRecord::Migration
  def change
    create_table :aerial_entries do |t|
      t.integer :user_id
      t.string :move_name
      t.string :apparatus 
      t.string :difficulty
      t.text :description
      t.string :image

      t.timestamps null: false
      #users will have many entries and entries belong to a user
    end
  end
end
