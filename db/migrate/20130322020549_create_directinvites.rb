class CreateDirectinvites < ActiveRecord::Migration
  def change
    create_table :directinvites do |t|

      t.timestamps
    end
  end
end
