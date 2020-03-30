class StaticPagesController < ApplicationController
  def home
    # it's too long. I think I should write this function to project model?
    @projects = current_user.open_projects.page params[:page] if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end 
end
