class Settings::EmailsController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        @user.update_attributes(email_verified: false)
        PasswordMailer.reset_password_email(@user).deliver_now
        format.html { redirect_to edit_settings_email_path , notice: t('.success') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email)
    end

end
