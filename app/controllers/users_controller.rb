class UsersController < ApplicationController

  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]



  def index
    if signed_in_user?
      @user = User.find( session[:user_id] )
      redirect_to user_path( @user )
    else
      redirect_to login_path
    end
  end


  def show
    @user = User.find( params[:id] )
  end


  def new

    if signed_in_user?
      @user = User.find( session[:user_id] )
      redirect_to user_path( @user )
    else
      @user = User.new
    end

  end


  def edit

    @user = User.find( params[:id] )

  end


  def create

    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)  # <<<<<<<
      flash[:success] = "Created new user!"
      redirect_to user_path( @user )
    else
      flash.now[:error] = "Failed to Create User!"
      render :new
    end

  end



  def update

    @user = User.find( params[:id] )
    if @user.update( whitelisted_user_params )
      flash[:success] = "Updated user!"
      redirect_to @user
    else
      flash.now[:error] = "Failed to Update User!"
      render :new
    end

  end


  def destroy

  end

  private


    def set_user
      @user = User.find(params[:id])
    end

    def whitelisted_user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end


    def authenticate
      authenticate_or_request_with_http_digest do | username |
        USERS[ username ]
      end
    end
end
