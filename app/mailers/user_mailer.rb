class UserMailer < ApplicationMailer

  def verify_email(user)
    @user = user
    return false if @user.email.nil?
    @user.update_attribute(:verify_email_time, DateTime.now)
    mail(to: @user.email, subject: @user.name + ', please verify your email')
  end

  def permit_email(user)
    @user = user
    return false if @user.blank?
    mail(to: @user.email, subject: @user.name + ', your application to join RTISS was honoured.')
  end

  def refuse_email(user)
    @user = user
    return false if @user.blank?
    mail(to: @user.email, subject: @user.name + ', your application to join RTISS has been refused.')
  end

end
