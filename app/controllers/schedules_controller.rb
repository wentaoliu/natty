class SchedulesController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /schedule
  # GET /schedule.json
  def index
    @start_date = params[:start_date].nil? ? Date.today : params[:start_date].to_date
    @user = params[:user].nil? ? current_user : User.find(params[:user])
    @schedules = Schedule.find_by_user_and_month(@user, @start_date.year, @start_date.month)
  end

  # GET /schedule/1
  # GET /schedule/1.json
  def show
  end

  # GET /schedule/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedule/1/edit
  def edit
  end

  # POST /schedule
  # POST /schedule.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user = current_user
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: t('.success') }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedule/1
  # PATCH/PUT /schedule/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: t('.success') }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedule/1
  # DELETE /schedule/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedule_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @schedule = Schedule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def schedule_params
    params.require(:schedule)
      .permit(:title, :content, :starts_at, :ends_at, :place, :public, :description)
  end
end
