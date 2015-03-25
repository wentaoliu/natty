class MeetingsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15.to_f

  # GET /meeting
  # GET /meeting.json
  def index
    @offset = params[:page].nil? ? 0 : NUM_PER_PAGE * (params[:page].to_i - 1)
    if params[:search].nil?
      count = Meeting.count
      @pages = (count / NUM_PER_PAGE).ceil
      @meetings = Meeting.limit(NUM_PER_PAGE).offset(@offset).order(created_at: :desc)
    else
      count = Meeting.where(title: /.*#{params[:search]}.*/i).count
      @pages = (count / NUM_PER_PAGE).ceil
      @meetings = Meeting.where(title: /.*#{params[:search]}.*/i)
                    .limit(@per_page).offset(@offset).order(created_at: :desc)
    end
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
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
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
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
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
      format.html { redirect_to meeting_url, notice: 'Meeting was successfully destroyed.' }
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
    params.require(:meeting).permit(:title, :starts_at, :ends_at, :content, :place, :public)
  end
end
