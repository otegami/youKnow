class MembersController < ApplicationController
  before_action :logged_in_user
  # before_action :correct_member

  def index
  end

  private
  def correct_member
    @project = current_user.projects.find_by(id: params[:project_id])
    member = current_user.members.find_by(project_id: params[:project_id])
    @project = member.project if member
    redirect_to root_url if @project.nil?
  end
end
