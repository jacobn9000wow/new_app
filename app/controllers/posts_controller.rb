class PostsController < ApplicationController

  before_filter :signed_in_user, only: [:new, :create, :destroy]

  def index
  end

  def new
   #@post = Post.new
   
   @room_id = params[:format] #:format? 

   #@room = Room.find(params[:format])
   #Room.find(18) works fine

   #@room = Room.find_by_id(params[:id])
   #@post = @room.posts.create()
  end

  #params include :room_id to post in     ?
  def create
    @room = Room.find(params[:target_room_id])
    @post = @room.posts.create(params[:post])
    @post.user_id = current_user.id

    if @post.save!
      flash[:success] = "Post created!"
      
      
    
    else
      flash[:failure] = "Failed to create post!"
    end
    redirect_to room_path(@room)
    
  end

  def destroy
  end


end
