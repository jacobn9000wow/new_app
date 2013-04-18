class RoomsController < ApplicationController

  before_filter :signed_in_user, only: [:new, :create, :destroy, :show]
  before_filter :correct_user, only: [:show]#, :add_member]	#correct_user checks if current_user is a member of this room

  def index
  end

  def new
    @room = Room.new
    
  end

  def create
    @room = Room.new(params[:room]) #current_user.rooms.build(params[:room])
    if @room.save
      flash[:success] = "Room created"

      #make a new Inclusion
      @room.include!(current_user)	#defined in models/room.rb
      					#self.inclusions.create!(included_user_id: current_user.id)

      #redirect_to root_url
      redirect_to room_path(@room)
    else
      render 'static_pages/home'
    end
  end

  

  #def join
    #@room = Room.find_by_id(params[:format]) #format or id ?
  #end

  #def admit_new_member
  #  room = Room.find(params[:room_id])
  #  if room.authenticate(params[:room_password])
  #    room.include!(current_user)
  #    flash[:success] = 'Room joined'
  # else
  #    flash[:error] = 'Invalid password'
  # end
  #end

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
    @posts.reverse!
    @users = @room.included_users
    #:room_id = params[:id]

    @room_id = @room.id #to be used in the form for a new post
    @post = Post.new

    

    respond_to do |format|
      format.html # show.html.erb
      format.json do        
          #make an array of hashes of posts/comments for json
          @post_tree = Array.new
          @posts.each do |p|

	    @comments = Array.new
            p.comments.each do |c|
              @comments << {:comment => c, :author => User.find(c.user_id).screenname}
            end

            @post_tree << {:top_level_post => p, :author => User.find(p.user_id).screenname, :comments => @comments}# p.comments}

          end
          render :json => {:posts => @post_tree } 
	#render :json => {:ok => "okay" } 
      end
    end

  end

  private

    def correct_user
      @room = current_user.including_rooms.find_by_id(params[:id])
      redirect_to root_url if @room.nil?
    end
  
end
