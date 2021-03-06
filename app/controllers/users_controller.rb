class UsersController < ApplicationController
  before_action :require_login, only: [:show, :invite]
  before_action :require_not_logged_in, only: [:forgot_password, :new, :reset_password_confirmation]

  def new
    @user = User.new(email: params[:email])
    @invited_by = params[:invited_by]
    render :register
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if params[:invited_by].present?
        inviting_user = User.find(params[:invited_by])
        Relationship.create_leading_and_following_relationship(@user, inviting_user)
      end
      UserMailer.welcome_email(@user).deliver
      flash[:success] = "Your account has been created, please log in."
      redirect_to login_path
    else
      render :register
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def forgot_password
    if request.get?
      render :forgot_password
    elsif request.post?
      @user = User.where(email: params[:email]).first
      if @user
        @user.set_token
        @url = reset_password_url(@user)
        UserMailer.reset_password_email(@user, @url).deliver
        redirect_to reset_password_confirmation_path
      else
        flash[:warning] = "No user matches the email address you entered."
        redirect_to forgot_password_path
      end
    end
  end

  def reset_password_confirmation
  end

  def reset_password
    if request.get?
      @user = User.where(token: params[:token]).first

      if @user
        render :reset_password
      else
        redirect_to root_path
      end
    elsif request.post?
      @user = User.where(token: params[:user][:token]).first
      if @user
        @user.password = params[:user][:password]
        @user.remove_token
        flash[:success] = "Your password has been reset, please log in."
        redirect_to login_path
      else
        redirect_to root_path
      end
    end
  end

  def invite
    if request.get?
      render :invite
    elsif request.post?
      email = params[:email]
      if User.email_already_taken?(email)
        flash[:warning] = "This user has already joined MyFlix."
        redirect_to invite_path
      else
        name = params[:name]
        message = params[:message]
        url = register_url(email: email, invited_by: helpers.current_user.id)
        UserMailer.invite_email(email, name, helpers.current_user, url, message).deliver
        flash[:success] = "You have invited #{name} to join MyFlix!"
        redirect_to people_path
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end