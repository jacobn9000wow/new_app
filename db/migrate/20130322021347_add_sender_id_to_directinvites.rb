class AddSenderIdToDirectinvites < ActiveRecord::Migration
  def change
    add_column :directinvites, :sender_id, :string
  end
end
