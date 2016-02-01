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
        token = sign_in(user = @user, permanent = params[:session][:remember_me] == '1')
        format.html {
          save_sign_in_info @user
          set_locale @user.locale
          redirect_to root_path, notice: t('.success_html', username: current_user.name)
        }
        format.json {
          render json: { token: token, user_id: @user._id.to_s }
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
