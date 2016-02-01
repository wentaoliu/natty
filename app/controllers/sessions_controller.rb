class SessionsController < ApplicationController
  skip_before_action :require_signin, except: [:destroy]
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
        format.html {
          sign_in_with_cookie(@user, params[:session][:remember_me] == '1')
          save_sign_in_info @user
          set_locale @user.locale
          redirect_to root_path, notice: t('.success_html', username: current_user.name)
        }
        format.json {
          token = sign_in_with_token(@user)
          render json: {
            token: token, username: @user.username,
            name: @user.name, email: @user.email,
            avatar: ActionController::Base.helpers.image_path(@user.avatar.url(:thumb))
          }
        }
      else
        # Failed!
        format.html {
          flash.now[:error] = t('.password_error')
          render 'new'
        }
        format.json { render json: { error: t('.password_error') }, status: :unprocessable_entity }
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

end
