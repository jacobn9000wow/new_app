class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :url
      t.integer :user_id
      t.integer :room_id
      t.integer :post_id

      t.timestamps
    end
  end
end
