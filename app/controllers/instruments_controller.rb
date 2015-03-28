class InstrumentsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_instrument, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15.to_f

  # GET /instruments
  # GET /instruments.json
  def index
    @offset = params[:page].nil? ? 0 : NUM_PER_PAGE * (params[:page].to_i - 1)
    if params[:search].nil?
      count = Instrument.count
      @pages = (count / NUM_PER_PAGE).ceil
      @instruments = Instrument.limit(NUM_PER_PAGE).offset(@offset)
                      .order(updated_at: :desc)
    else
      count = Instrument.where(title: /.*#{params[:search]}.*/i).count
      @pages = (count / NUM_PER_PAGE).ceil
      @instruments = Instrument.where(title: /.*#{params[:search]}.*/i)
                      .limit(NUM_PER_PAGE).offset(@offset).order(updated_at: :desc)
    end
  end

  # GET /instruments/1
  # GET /instruments/1.json
  def show
  end

  # GET /instruments/new
  def new
    @instrument = Instrument.new
  end

  # GET /instruments/1/edit
  def edit
  end

  # POST /instruments
  # POST /instruments.json
  def create
    @instrument = Instrument.new(instrument_params)
    @instrument.user = current_user
    respond_to do |format|
      if @instrument.save
        format.html { redirect_to instruments_path(@instrument),
                      notice: t('.success') }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instruments/1
  # PATCH/PUT /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to @instrument, notice: t('.success') }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html { render :edit }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.json
  def destroy
    @instrument.destroy
    respond_to do |format|
      format.html { redirect_to instruments_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_instrument
    @instrument = Instrument.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def instrument_params
    params.require(:instrument).permit(:title, :content, :maintainer, :public)
  end
end
