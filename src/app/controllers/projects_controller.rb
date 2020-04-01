class ProjectsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
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
    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_url if @project.nil?
    end
end
