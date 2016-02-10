class SessionsController < ApplicationController
  skip_before_action :require_signin, except: [:destroy]
  skip_before_action :store_return_to
  include SimpleCaptcha::ControllerHelpers

  layout 'layouts/visitor'

  def new
    redirect_to root_path if signed_in?
  end

  def create
    params.require(:session)
    @user = User.find_and_authenticate(
      params[:session][:username], params[:session][:password]
    )
    respond_to do |format|
      if @user
        # Sign in successful
        token = sign_in(@user, params[:session][:remember_me] == '1')
        save_sign_in_info @user
        set_locale @user.locale
        format.html {
          redirect_to after_sign_in_path, notice: t('.success_html', username: current_user.name)
        }
        format.json {
          render status: :created, json: { remember_token: token }
        }
      else
        # Failed!
        format.html {
          flash.now[:error] = t('.password_error')
          render 'new'
        }
        format.json { render json: { error: t('.password_error') }, status: :unauthorized }
      end
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

  def after_sign_in_path
    session[:return_to] || root_path
  end
end
