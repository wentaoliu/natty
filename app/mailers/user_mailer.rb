class UserMailer < ApplicationMailer
  def verify_email()
    #@user = User.find_by_id(user_id)
    #return false if @user.blank?
    mail(to: 'wentaoliu@live.com', subject: "Hello!")
  end

  def reset_password_email(user)

  end
end
