class CreateAerialEntries < ActiveRecord::Migration
  def change
    create_table :aerial_entries do |t|

      t.timestamps null: false
    end
  end
end
