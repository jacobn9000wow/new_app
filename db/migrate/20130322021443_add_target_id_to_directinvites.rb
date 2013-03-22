class AddTargetIdToDirectinvites < ActiveRecord::Migration
  def change
    add_column :directinvites, :target_id, :string
  end
end
