class InvitationsController < ApplicationController
  
  def redeem
   # >check token
    #room_id = Invitation.find_by_token(params[:token]).room_id
    @invitation = Invitation.find_by_token(params[:token])
    if signed_in?
      #Room.find(params[:room_id]).add_member(current_user)
      Room.find(@invitation.room_id).include!(current_user)
      redirect_to room_path(@room)
      return
    else
      #new_invite(room_id) #redirect_to '/users/new_invite/:room_id' #new_invite_path()#'/users/new_invite/:room_id'
      #@user = User.new

      #@user.save  #so it has an id, so we can set it's relationships

      #user was invited -add to a room!
      #Room.find(room_id).add_member(@user)
      #Room.find_by_id(@invitation.room_id).include!(@user)

      #go to the usual signup page
      redirect_to signup_path(params[:token])
      return
    end
  end

  #def new_invite(room_id) #moved here from users controller ... copied to above method
  #  @user = User.new

    #@user.save  #so it has an id, so we can set it's relationships

    #user was invited -add to a room!
    #Room.find(room_id).add_member(@user)
  #  Room.find(room_id).include!(@user.id)

    #go to the usual signup page
  #  render 'users#new'
 # end

  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invitations }
    end
  end

  # GET /invitations/1            - :token instead of :id
  # GET /invitations/1.json
  def show
    #@invitation = Invitation.find(params[:id])
    @invitation = Invitation.find_by_token(params[:token])

    @already_in_group = false
    @room = Room.find(@invitation.room_id)
    
    if @room.including?(current_user)
      @already_in_group = true
    end

    unless @invitation
      redirect_to root_url
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @invitation = Invitation.new
    @invitation.room_id = params[:format] #:format instead of :room_id for some reason
    @invitation.sender_id = current_user#.user_id
    @invitation.save

    @invite_url = "localhost:3000/invitation/" + @invitation.token#.to_string

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @invitation }
    #end
  end

  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id])
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(params[:invitation])
    

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'Invitation was successfully created.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url }
      format.json { head :no_content }
    end
  end
end
