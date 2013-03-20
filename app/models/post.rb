class Post < ActiveRecord::Base
  attr_accessible :content, :room_id, :title, :url, :user_id#, :post_id

  #belongs_to :user 
  

  belongs_to :room
  has_many :comments
  
  validates :content, presence: true#, length: { maximum: 500 }
  validates :user_id, presence: true
end
