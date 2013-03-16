class AddIndexToUsersEmail < ActiveRecord::Migration
  def change    
    add_index :users, :email, unique: true  # Adding this index on the email attribute accomplishes a second goal, alluded to briefly in Section 6.1.4: it fixes an efficiency problem in find_by_email (Box 6.2).
  end
end
