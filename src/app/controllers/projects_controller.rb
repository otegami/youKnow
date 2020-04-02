class ProjectsController < ApplicationController
  before_action :logged_in_user
  # Not only owner but also members can access show action
  before_action :correct_owner, only: [:show, :edit, :update, :destroy]
  before_action :manage_project, only: [:edit, :update, :destroy]
  def show
    @project = Project.find(params[:id])
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
    
    # You have to check whether this user is a member in this project too.
    def correct_owner
      @member = current_user.members.find_by(project_id: params[:id])
      redirect_to root_url unless @member && @member.owner
    end

    def manage_project
      @project = @member.project
    end
end
