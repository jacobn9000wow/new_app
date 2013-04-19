class PostsController < ApplicationController

  before_filter :signed_in_user, only: [:new, :create, :destroy]
  before_filter :correct_user,   only: :destroy

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
    @success = false

    if @post.save
      flash[:success] = "Post created!"
      @success = true
    
    else
      flash[:failure] = "Failed to create post. Posts cannot be empty."
      @success = false
    end
    

    respond_to do |format|
      format.html { redirect_to room_path(@room) }# show.html.erb
      format.json { render :json => {:success => @success}} 
    end
    
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @room = Room.find(@post.room_id)
    @post.destroy
    flash[:success] = "Post deleted!"
    redirect_to room_path(@room)
  end

  private

    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      #flash[:failure] = "Cannot delete another user's posts"
      redirect_to root_url if @post.nil?
    end
end
