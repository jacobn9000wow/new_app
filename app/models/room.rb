class Room < ActiveRecord::Base
  attr_accessible :room_name, :room_id

  #has_many :users
  has_many :inclusions, foreign_key: "including_room_id" 
  has_many :included_users, through: :inclusions, source: :included_user

  has_many :posts

  #def add_member	#maybe make private?
  #  @user = User.find_by_id(params[:user_id])
  #  room = Room.find(params[:room_id])

    #maybe check if both users (current user(inviter) and invitee) have rooms in common ?   

  # room.include!(@user)
 # end

  def including?(a_user)
    inclusions.find_by_included_user_id(a_user.id)
  end

  def include!(a_user)
    inclusions.create!(included_user_id: a_user.id)
  end

  def exclude!(a_user)
    inclusions.find_by_included_user_id(a_user.id).destroy
  end
end
