class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :destroy] #The authorization application code uses a before filter, which arranges for a particular method to be called before the given actions. To require users to be signed in, we define a signed_in_user method and invoke it using before_filter :signed_in_user, 
  before_filter :correct_user,   only: [:edit, :update, :destroy, :show]
  before_filter :admin_user,     only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #Note that we can omit the user_url in the redirect, writing simply redirect_to @user to redirect to the user show page.
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def groups
    @title = "Groups"
    @user = User.find(params[:id])
    @rooms = @user.including_rooms.paginate(page: params[:page])
    render 'show_groups'
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        #redirect_to signin_url, notice: "Please sign in."
 	flash[:notice] = "Please sign in."
	redirect_to signin_path
      end

#uses a shortcut for setting flash[:notice] by passing an options hash to the redirect_to function. Together with :success and :error, the :notice key completes our triumvirate of flash styles, all of which are supported natively by Bootstrap CSS. http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-authorize_before_filter
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)  #current_user? defined in sessions helper
        flash[:notice] = "Please sign in."
        redirect_to(root_path) #unless current_user?(@user)  #current_user? defined in sessions helper
      end

			
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
