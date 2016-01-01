class MeetingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /meeting
  # GET /meeting.json
  def index
    res = can?(:create, Meeting) ? Meeting : Meeting.where(hidden: false)
    if params[:search].present?
      res = res.where(title: /.*#{params[:search]}.*/i)
    end
    @meetings = res.order(updated_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /meeting/1
  # GET /meeting/1.json
  def show
  end

  # GET /meeting/new
  def new
    @meeting = Meeting.new
  end

  # GET /meeting/1/edit
  def edit
  end

  # POST /meeting
  # POST /meeting.json
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: t('.success') }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meeting/1
  # PATCH/PUT /meeting/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: t('.success') }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting/1
  # DELETE /meeting/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meeting_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meeting_params
    params.require(:meeting).permit(:title, :starts_at, :ends_at, :content, :place, :hidden)
  end
end
