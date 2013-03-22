class Directinvite < ActiveRecord::Base
   attr_accessible :sender_id, :target_id, :room_id

   belongs_to :sender, class_name: "User"
   belongs_to :target, class_name: "User"
   belongs_to :room, class_name: "Room"
end
