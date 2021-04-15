class UsersController < ApplicationController
  def new
    @user = User.new
    render 'ui/register', layout: 'logged_out'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/home'
    else
      render 'ui/register', layout: 'logged_out'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest, :full_name)
  end
end