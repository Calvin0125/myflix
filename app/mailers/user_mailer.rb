class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail to: @user.email, subject: 'Welcome to MyFlix'
  end

  def reset_password_email(user, url)
    @user, @url = user, url
    mail to: @user.email, subject: 'Reset MyFlix Password'
  end
end