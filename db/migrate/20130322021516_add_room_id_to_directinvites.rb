class AddRoomIdToDirectinvites < ActiveRecord::Migration
  def change
    add_column :directinvites, :room_id, :string
  end
end
