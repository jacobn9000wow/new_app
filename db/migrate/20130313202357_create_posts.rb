class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :url
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
