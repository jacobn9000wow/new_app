class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :room_id
      t.integer :sender_id
      t.string :token
      t.datetime :sent_at

      t.timestamps
    end
  end
end
