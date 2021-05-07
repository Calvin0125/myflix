class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail to: @user.email, subject: 'Welcome to MyFlix'
  end

  def reset_password_email(user, url)
    @user, @url = user, url
    mail to: @user.email, subject: 'Reset MyFlix Password'
  end

  def invite_email(email, invited_name, invited_by_user, url, message)
    @email, @invited_by_user, @invited_name, @url, @message = email, invited_by_user, invited_name, url, message
    mail to: @email, subject: "#{@invited_by_user.full_name} has invited you to join MyFlix!"
  end
end