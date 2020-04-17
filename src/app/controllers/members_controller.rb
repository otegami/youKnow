class MembersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: [:index, :new]
  before_action :correct_owner, only: [:new, :create, :destroy]
  before_action :manage_members, only: :index
  before_action :check_project, only: [:index, :new, :create]

  def index
  end

  def new
  end

  def create
    user = User.find_by(email: params[:member][:user_email])
    if user && !(current_user == user)
      if user.be_added_to(@project)
        flash[:success] = "#{user.name} is added !!"
        redirect_to project_members_path(@project)
      else
        flash.now[:danger] = "This user has already been added !!"   
        render 'new'
      end
    else
      flash.now[:danger] = 'Sorry!! User cannot be found' 
      render 'new'
    end
  end

  def destroy
    member = Member.find(params[:id])
    unless member.owner
      flash[:success] = "#{member.user.name} is removed"
      member.destroy 
    end
    redirect_to request.referrer || root_url
  end

  private

  def correct_member
    @member = current_user.member?(params[:project_id])
    redirect_to root_url if @member.nil?
  end

  def correct_owner
    @member = current_user.members.find_by(project_id: params[:project_id])
    redirect_to root_url unless @member && @member.owner
  end

  def manage_members
    @members = Member.where("project_id = ?", params[:project_id]).page params[:page]
  end

  def check_project
    @project = Project.find(params[:project_id])
  end
end
