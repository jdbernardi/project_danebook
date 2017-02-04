class UsersController < ApplicationController

  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]



  def index
    @users = User.all
  end


  def show
    @user = User.find( params[:id] )
  end


  def new
    @user = User.new
  end


  def edit

    @user = User.find( params[:id] )

  end


  def create

    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)  # <<<<<<<
      flash[:success] = "Created new user!"
      redirect_to @user
    else
      flash.now[:error] = "Failed to Create User!"
      render :new
    end

  end



  def update
byebug
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
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end


    def authenticate

      authenticate_or_request_with_http_digest do | username |
        USERS[ username ]
      end


    end
end
