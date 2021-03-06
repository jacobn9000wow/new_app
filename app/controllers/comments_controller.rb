class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def create
    @post = Post.find(params[:target_post_id])
    @comment = @post.comments.create(params[:comments])
    @comment.user_id = current_user.id
    @comment.room_id = @post.room_id

    @success = false

    if @comment.save!
      flash[:success] = "Comment created!" 
      @success = true      
    else
      flash[:failure] = "Failed to create comment!"
    end

    @room = @post.room

    #@target_room_id = params[:target_room_id]
    respond_to do |format|
      format.html { redirect_to room_path(@room) }# show.html.erb
      format.json { render :json => {:success => @success}} 
    end

  end

   def destroy
    @comment = Comment.find_by_id(params[:id])
    @room = Room.find(@comment.room_id)
    @comment.destroy
    flash[:success] = "Comment deleted!"
    redirect_to room_path(@room)
  end

  private

    def correct_user
      @comment = current_user.comments.find_by_id(params[:id])
      #flash[:failure] = "Cannot delete another user's posts"
      redirect_to root_url if @comment.nil?
    end

end
