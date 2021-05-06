class ApplicationController < ActionController::Base
  def require_login
    if !helpers.logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

  def require_not_logged_in
    if helpers.logged_in?
      flash[:warning] = "You are already logged in."
      redirect_to home_path
    end
  end
end
