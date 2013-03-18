class Invitation < ActiveRecord::Base
  attr_accessible :room_id, :sender_id, :sent_at, :token

  before_create :generate_token

  private

    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end

end
