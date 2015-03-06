class SessionsController < ApplicationController
  before_filter :require_signin, only: [:destroy]

  def new
    redirect_to root_path if signed_in?
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user and user.authenticate(params[:session][:password])
      # Sign in successful
      sign_in user
      save_sign_in_info user
      set_custom_locale user
      redirect_to root_path
    else
      # Failed!
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end

  private

  def save_sign_in_info(user)
    user.update!(
      last_sign_in_ip: user.current_sign_in_ip,
      current_sign_in_ip: request.remote_ip,
      last_sign_in_at: user.current_sign_in_at,
      current_sign_in_at: DateTime.now
    )
  end

  def set_custom_locale(user)
    if user.locale
      session[:locale] = user.locale
    else
      session[:locale] ||= I18n.default_locale
    end
    I18n.locale = session[:locale]
  end

end
