class TagsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: [:index, :new]
  before_action :manage_tags, only: :index
  before_action :check_project, only: [:index, :new]

  def index
  end

  def new
    @tag = Tag.new
  end

  private 
  # I think I can rewrite this method into shared method
  # for all controllers in project
  def correct_member
    @member = current_user.members.find_by(project_id: params[:project_id])
    redirect_to root_url if @member.nil?
  end

  def manage_tags
    @tags = Tag.where("project_id = ?", params[:project_id]).page params[:page]
  end

  def check_project
    @project = Project.find(params[:project_id])
  end
end
