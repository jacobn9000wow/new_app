class RoomsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy, :show]
  before_filter :correct_user, :show

  def index
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room]) #current_user.rooms.build(params[:room])
    if @room.save
      flash[:success] = "Room created!"

      #make a new Inclusion
      @room.include!(current_user)	#defined in models/room.rb
      					#self.inclusions.create!(included_user_id: current_user.id)

      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  #params include :room_id to post in     ?
  #def new_post
    #@room = Room.find(params[:room_id])
    #@post = @room.posts.create(params[:content])
    #redirect_to room_path(@room)

    #@post = current_room.posts.build
  #end

  def destroy
  end

  def show
    @room = Room.find(params[:id])
    @posts = @room.posts
    @users = @room.included_users
    #:room_id = params[:id]
  end

  private

    def correct_user
      @room = current_user.including_rooms.find_by_id(params[:id])
      redirect_to root_url if @room.nil?
    end
  
end
