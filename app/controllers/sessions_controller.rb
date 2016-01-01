class SessionsController < ApplicationController
  skip_before_action :require_signin, except: [:destroy]
  include SimpleCaptcha::ControllerHelpers

  layout 'layouts/visitor'

  def new
    redirect_to root_path if signed_in?
  end

  def create
    if simple_captcha_valid?
      user = User.where(username: params[:session][:username].downcase).first
      if user and user.authenticate(params[:session][:password]) and user.normal?
        # Sign in successful
        sign_in(user = user, permanent = params[:session][:remember_me] == '1')
        save_sign_in_info user
        set_locale user.locale
        redirect_to root_path, notice: t('.success_html', username:current_user.name)
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

end
