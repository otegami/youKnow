class TagsController < ApplicationController
  before_action :logged_in_user
  before_action :manage_tags, only: [:index,:edit, :update, :destroy]
  before_action :correct_member, only: [:index, :new, :create, :edit, :update]
  before_action :correct_owner, only: :destroy
  before_action :check_project, only: [:index, :new, :create]

  def index
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = @project.tags.build(tag_params)
    if @tag.save
      flash[:success] = "Tag is added !!"
      redirect_to project_tags_path(@project)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @tag.update_attributes(tag_params)
      flash[:success] = 'Tag Update'
      redirect_to project_tags_path(@tag.project)
    else
      render 'edit'
    end
  end

  def destroy
    flash[:success] = "#{@tag.name} is removed"
    @tag.destroy
    redirect_to request.referrer || root_url
  end

  private 
  # I think I can rewrite this method into shared method
  # for all controllers in project
  def tag_params
    params.require(:tag).permit(:name)
  end

  def correct_member
    @member = current_user.member?(params[:project_id] || @tag.project_id)
    redirect_to root_url if @member.nil?
  end

  def correct_owner
    @member = current_user.members.find_by(project_id: params[:project_id])
    redirect_to root_url unless @member && @member.owner
  end

  def manage_tags
    return @tag = Tag.find(params[:id]) if params[:id]
    @tags = Tag.where("project_id = ?", params[:project_id]).page params[:page]
  end

  def check_project
    @project = Project.find(params[:project_id])
  end
end
