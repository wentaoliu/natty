class SessionsController < ApplicationController
  before_filter :require_signin, only: [:destroy]
  include SimpleCaptcha::ControllerHelpers

  def new
    redirect_to root_path if signed_in?
  end

  def create
    if simple_captcha_valid?
      user = User.where(username: params[:session][:username].downcase).first
      if user and user.authenticate(params[:session][:password])
        # Sign in successful
        if params[:session][:remember_me] == '1'
          sign_in_permanent user
        else
          sign_in user
        end
        save_sign_in_info user
        set_custom_locale user
        redirect_to root_path, notice: t('.success_html',username:current_user.name)
      else
        # Failed!
        flash.now[:error] = t('.password_error')
        render 'new'
      end
    else
      # Failed!
      flash.now[:error] = t('.code_error')
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
