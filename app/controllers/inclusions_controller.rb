class InclusionsController < ApplicationController
  before_filter :signed_in_user

  def create
    @room = Room.find(params[:inclusion][:included_id])
    current_user.be_included!(@room)
    redirect_to @room
  end
  
  def destroy
    #@room = Inclusion.find(params[:room_id]).included
    #current_user
  end

end
