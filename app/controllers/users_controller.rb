class UsersController < ApplicationController
  def new
    @user = User.new
    render 'ui/register'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:message] = "Your account has been created, please log in."
      redirect_to '/login'
    else
      render 'ui/register'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end