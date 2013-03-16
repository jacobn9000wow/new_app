class Inclusion < ActiveRecord::Base
  attr_accessible :included_user_id, :including_room_id

  belongs_to :included_user, class_name: "User"
  belongs_to :including_room, class_name: "Room"

  validates :included_user_id, presence: true
  validates :including_room_id, presence: true
end
