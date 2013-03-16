class Room < ActiveRecord::Base
  attr_accessible :room_name, :room_id

  #has_many :users
  has_many :inclusions, foreign_key: "including_room_id" 
  has_many :included_users, through: :inclusions, source: :included_user

  has_many :posts

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
