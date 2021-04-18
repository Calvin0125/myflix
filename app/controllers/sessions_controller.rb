class SessionsController < ApplicationController
  def new
    if helpers.logged_in?
      flash[:message] = "You are already logged in."
      redirect_to home_path
    else
      render :login
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "You have been logged in."
      redirect_to home_path
    else
      flash[:message] = "Invalid username or password"
      render :login
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = "You have been logged out."
    redirect_to root_path
  end
end