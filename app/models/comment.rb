class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id, :room_id, :url, :user_id

  belongs_to :post
end
