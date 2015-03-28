class PasswordMailer < ApplicationMailer

  def reset_password_email(user)
    @user = user
    return false if @user.email.nil?
    @user.update_attribute(:reset_password_time, DateTime.now)
    mail(to: @user.email, subject: t('.subject', user: @user.name))
  end

end
