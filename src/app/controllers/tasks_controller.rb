class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: [:new, :create]
  before_action :check_project, only: [:new, :create]

  def new
    @task_form = TaskForm.new
    @members = @project.members
  end

  def create
    @task_form = TaskForm.new(task_form_params)
    if @task_form.save
      flash[:success] = "Task created"
      redirect_to project_path(@project)
    else
      @members = @project.members
      render 'new'
    end
  end

  private
  def task_form_params
    params.require(:task).permit(
      :name,
      :deadline,
      :content,
      :priority,
      :project_id,
      pic_attributes: [
        :user_id
      ]
    )
  end
  def correct_member
    @member = current_user.member?(params[:project_id])
    redirect_to root_url if @member.nil?
  end

  def check_project
    @project = Project.find(params[:project_id])
  end
end
