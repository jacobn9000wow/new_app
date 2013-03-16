class CreateInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.integer :included_user_id
      t.integer :including_room_id

      #t.boolean :invite_priviledges
      #t.boolean :

      t.timestamps
    end

  add_index :inclusions, :included_user_id
  add_index :inclusions, :including_room_id
  add_index :inclusions, [:included_user_id, :including_room_id], unique: true
  end
end
