class StatusController < ApplicationController
  before_action :logged_in_user
  before_action :manage_tasks
  before_action :correct_pic
  before_action :correct_member

  def create
    task_status = TaskStatus.new(status_params)
    if task_status.update
      flash[:success] = "Update Task Status"
      project_task_path(@task)
    else
      flash[:danger] = "Failed To Update Task Status"
      project_task_path(@task)
    end
  end

  private
  def status_params
    params.require(:task).permit(
      :status,
      :task_id
    )
  end

  def manage_tasks
    @task = Task.find(params[:task][:task_id]) if params[:task][:task_id]
  end

  def correct_pic
    redirect_to root_url unless pic_user?(@task)
  end

  def correct_member
    @member = current_user.member?(params[:project_id])
    redirect_to root_url if @member.nil?
  end
end