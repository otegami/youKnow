class MembersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: [:index, :new]
  before_action :correct_owner, only: :new
  before_action :manage_members, only: :index
  before_action :check_project, only: [:index, :new]

  def index
  end

  def new
  end

  private
  def correct_member
    @member = current_user.members.find_by(project_id: params[:project_id])
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
