class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.where(activated: true).order(:name).page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects.where(status: true).page params[:page]
    redirect_to root_path and return unless @user.activated
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = "Please check your email to activate your account"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end    
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end  

  private
    def user_params
      params.require(:user).permit(
        :name, 
        :email, 
        :password,
        :password_confirmation
      )
    end 
    
    # check whether the user corresponds with current_user or not
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # check whether current_user is admin or not
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end  
end
