class UsersController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  before_filter :require_admin, except: [:new, :create, :verify]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout 'layouts/visitor', only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
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
      @user = User.new(params.require(:user)
        .permit(:username, :name, :email, :password, :password_confirmation))
      @user.verify_email_token = User.new_remember_token
      respond_to do |format|
        if @user.save
          UserMailer.verify_email(@user).deliver_now
          format.html { redirect_to root_path, notice: 'please check your inbox' }
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
      if @user.update(params.require(:user)
          .permit(:username, :name, :email, :position, :grade, :photo, :avatar,
                  :resume, :state, :rank))
        if state == 0
          if @user.state == 1
            UserMailer.permit_email(@user).deliver_now
          else
            UserMailer.refuse_email(@user).deliver_now
          end
        end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify
    @user = User.where(verify_email_token: params[:token]).first
    redirect_to root_path, notice: 'invalid link' and return false unless @user

    if @user.verify_email_time + 3.day < DateTime.now
      redirect_to root_path, notice: 'address expired' and return false
    end

    respond_to do |format|
      if @user.update(email_verified: true)
        format.html { redirect_to root_path, notice: 'email was successfully verified' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to root_path, notice: 'email verification failed' }
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
