class ProjectsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: :show
  before_action :correct_owner, only: [:edit, :update, :destroy]
  before_action :manage_project, only: [:edit, :update, :destroy]
  
  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
  end

  def new
    @project = Project.new 
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      current_user.be_owner(@project)
      flash[:success] = "Porject created"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = 'Project Update'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @project.closed
    flash[:success] = "Project closed"
    redirect_to request.referrer || root_url
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
    
    def correct_member
      @member = current_user.members.find_by(project_id: params[:id])
      redirect_to root_url if @member.nil?
    end

    def correct_owner
      @member = current_user.members.find_by(project_id: params[:id])
      redirect_to root_url unless @member && @member.owner
    end

    def manage_project
      @project = @member.project
    end
end
