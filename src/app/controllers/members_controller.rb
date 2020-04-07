class MembersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: :index
  before_action :manage_members, only: :index

  def index
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
    @project = Project.find(params[:project_id])
  end
end
