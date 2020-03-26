class ProjectsController < ApplicationController
  before_action :logged_in_user
  
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
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
