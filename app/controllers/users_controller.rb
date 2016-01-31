class UsersController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  load_and_authorize_resource except: [:create]
  skip_authorize_resource only: [:new, :create, :verify]
  skip_before_action :require_signin, only: [:new, :create, :verify]
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

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if simple_captcha_valid?
      user_params = params.require(:user)
        .permit(:username, :name, :email, :password, :password_confirmation)
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          UserMailer.verify_email(@user).deliver_now
          format.html { redirect_to root_path, notice: t('.success') }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      render :new # validation code error
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    state = @user.state
    respond_to do |format|
      user_params = params.require(:user)
        .permit(:username, :name, :email, :position, :grade, :photo, :avatar,
          :resume, :state, :rank, :email_public, :admin,
          permission_attributes: [:topic, :comment, :achievement, :bulletin,
            :instrument, :meeting, :news, :resource, :wiki])
      if @user.update(user_params)
        if state == 0
          if @user.state == 1
            UserMailer.permit_email(@user).deliver_now
          else
            UserMailer.refuse_email(@user).deliver_now
          end
        end
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

  def verify
    @user = User.where(verify_email_token: params[:token]).first
    redirect_to root_path, notice: t('.invalid') and return false unless @user

    if @user.verify_email_time + 3.day < DateTime.now
      redirect_to root_path, notice: t('.expired') and return false
    end

    respond_to do |format|
      if @user.update(email_verified: true)
        format.html { redirect_to root_path, notice: t('.success') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to root_path, notice: t('.failure') }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

end
