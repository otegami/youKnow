class TasksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: :new

  def new
  end

  private
  def correct_member
    @member = current_user.member?(params[:project_id])
    redirect_to root_url if @member.nil?
  end
end
