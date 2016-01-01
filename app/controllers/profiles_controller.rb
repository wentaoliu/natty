class ProfilesController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(params.require(:user)
          .permit(:name, :email_public, :position, :grade, :resume))
        format.html { redirect_to edit_profile_path, notice: t('.success') }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def photo
    respond_to do |format|
      if @user.update(params.require(:user).permit(:photo))
        format.html { redirect_to edit_profile_path, notice: t('.success') }
        format.json { render :edit, status: :ok, location: @user }
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

end
