class UserMailer < ApplicationMailer

  def verify_email(user)
    @user = user
    return false if @user.email.nil?
    @user.update_attribute(:verify_email_time, DateTime.now)
    mail(to: @user.email, subject: t('.subject', user: @user.name))
  end

  def permit_email(user)
    @user = user
    return false if @user.blank?
    mail(to: @user.email, subject: t('.subject', user: @user.name))
  end

  def refuse_email(user)
    @user = user
    return false if @user.blank?
    mail(to: @user.email, subject: t('.subject', user: @user.name))
  end

end
