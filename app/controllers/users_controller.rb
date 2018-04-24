class UsersController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout 'layouts/visitor', only: [:new, :create]

  NUM_PER_PAGE = 20

  # GET /users
  # GET /users.json
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t('.success') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:admin)
    end

end
