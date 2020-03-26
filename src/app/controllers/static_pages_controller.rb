class StaticPagesController < ApplicationController
  def home
    @porjectsd = current_user.projects if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end 
end
