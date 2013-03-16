class CommentsController < ApplicationController
  before_filter :signed_in_user

  def create
    @post = Post.find(params[:target_post_id])
    @comment = @post.comments.create(params[:comments])
    @comment.user_id = current_user.id

    if @comment.save!
      flash[:success] = "Comment created!"
      
      
    
    else
      flash[:failure] = "Failed to create comment!"
    end

    @room = @post.room
    redirect_to room_path(@room)
  end

end
