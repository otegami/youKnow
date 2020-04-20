class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: :new
  before_action :check_project, only: :new

  def new
    @task = @project.tasks.build
    @members = @project.members
  end

  private
  def correct_member
    @member = current_user.member?(params[:project_id])
    redirect_to root_url if @member.nil?
  end

  def check_project
    @project = Project.find(params[:project_id])
  end
end
