class Settings::PasswordsController < ApplicationController
  before_action :require_signin
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    password = params.require(:password)
    @user = current_user
    if @user.authenticate(password[:old])
      if password[:new] == password[:repeat]
        password_confirmation = BCrypt::Password.create(password[:new])
        respond_to do |format|
          if @user.update(password: password[:new])
            format.html { redirect_to edit_settings_password_path, notice: t('.success') }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      else
        render :edit, notice: "Incorrect Password."
      end
    else
      render :edit, notice: "Incorrect Password."
    end
  end

  private

    def set_user
      @user = current_user
    end

end
