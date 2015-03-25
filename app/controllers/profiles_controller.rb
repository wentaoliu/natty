class ProfilesController < ApplicationController
  before_filter :require_signin
  before_action :set_user, only: [:show, :edit]

  def show
    
  end

  def edit

  end

  def update

  end

  private

  def set_user
    @user = current_user
  end
end
