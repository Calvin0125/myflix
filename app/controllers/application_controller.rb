class ApplicationController < ActionController::Base
  def require_login
    if !helpers.logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to '/'
    end
  end
end
