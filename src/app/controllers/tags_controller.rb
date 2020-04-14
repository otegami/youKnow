class TagsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: :index

  def index
  end

  private 
  # I think I can rewrite this method into shared method
  # for all controllers in project
  def correct_member
    @member = current_user.members.find_by(project_id: params[:project_id])
    redirect_to root_url if @member.nil?
  end
end
