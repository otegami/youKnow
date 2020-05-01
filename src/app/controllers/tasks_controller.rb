class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :manage_tasks, only: [:show, :edit, :update]
  before_action :correct_pic, only: :edit
  before_action :correct_member, only: [:show, :new, :create, :edit]
  before_action :check_project, only: [:new, :create, :edit, :update]

  def show
  end

  def new
    @task_form = TaskForm.new
    @members = @project.members
    @tags = @project.tags
  end

  def create
    @task_form = TaskForm.new(task_form_params)
    @task_form.current_user = current_user
    if @task_form.save
      flash[:success] = "Task created"
      redirect_to project_path(@project)
    else
      @members = @project.members
      @tags = @project.tags
      render 'new'
    end
  end

  def edit
    @task_form = TaskForm.find(params[:id])
    @members = @project.members
    @tags = @project.tags
  end

  def update
    @task_form = TaskForm.new(task_form_params)
    if @task_form.update(params[:id])
      redirect_to project_path(@project)
    else
      @task_form = TaskForm.find(params[:id])
      @members = @project.members
      @tags = @project.tags
      render 'edit'
    end
  end

  # def persisted?
  #   task_attributes.nil? ? false : true
  # end

  private
  def task_form_params
    params.require(:task_form).permit(
      :name,
      :deadline,
      :content,
      :priority,
      :project_id,
      pic_attributes: [
        :user_id
      ],
      taggings_attributes: [
        :tag_ids => []
      ]
    )
  end

  def correct_member
    @member = current_user.member?(params[:project_id] || @task.project_id)
    redirect_to root_url if @member.nil?
  end

  def check_project
    @project = Project.find(params[:project_id] || @task.project_id)
  end

  def manage_tasks
    @task = Task.find(params[:id]) if params[:id]
  end

  def correct_pic
    redirect_to root_url unless pic_user?(@task)
  end
end
