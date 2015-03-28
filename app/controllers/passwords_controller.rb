class PasswordsController < ApplicationController
  #before_filter :require_signin
  before_action :verify_token, only: [:edit, :update]
  include SimpleCaptcha::ControllerHelpers

  layout 'layouts/visitor'

  def new
  end

  def create
    if simple_captcha_valid?
      @user = User.where(username: params[:user][:username],
                        email:    params[:user][:email]).first
      if @user
        if @user.email_verified
          @user.update_attribute(:reset_password_token, User.new_remember_token)
          PasswordMailer.reset_password_email(@user).deliver_now
          redirect_to root_path, notice: 'please check your inbox.'
        else
          render :new # email address didn't verified
        end
      else
        render :new # wrong username/email match
      end
    else
      render :new # validation code error
    end
  end

  def edit
  end

  def update
    password = params.require(:password)
    if password[:new] == password[:repeat]
      password_confirmation = BCrypt::Password.create(password[:new])
      respond_to do |format|
        if @user.update(password: password[:new], reset_password_token: '')
          format.html { redirect_to root_path, notice: 'password was successfully changed' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      render :edit, notice: "Incorrect Password."
    end
  end

  private

  def verify_token
    @user = User.where(reset_password_token: params[:token]||params[:password][:token]).first
    redirect_to root_path, notice: 'invalid link' and return false unless @user

    if @user.reset_password_time + 3.day < DateTime.now
      redirect_to root_path, notice: 'address expired' and return false
    end
  end

end
