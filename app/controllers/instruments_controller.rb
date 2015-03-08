class InstrumentsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_instrument, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /instruments
  # GET /instruments.json
  def index
    @offset = params[:page].nil? ? 0 : NUM_PER_PAGE * (params[:page].to_i - 1)
    if params[:search].nil?
      count = Instrument.count
      @pages = (count / NUM_PER_PAGE).ceil
      @instruments = Instrument.limit(NUM_PER_PAGE).offset(@offset)
    else
      count = Instrument.where("title LIKE ?", "%#{params[:search]}%").count
      @pages = (count / NUM_PER_PAGE).ceil
      @instruments = Instrument.where("title LIKE ?", "%#{params[:search]}%").limit(NUM_PER_PAGE).offset(@offset)
    end
  end

  # GET /instruments/1
  # GET /instruments/1.json
  def show
    @article = @instrument.articles.order(created_at: :desc).first()
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

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to new_instrument_article_path(@instrument),
                      notice: 'Instrument was successfully created.' }
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
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to instruments_url, notice: 'User was successfully destroyed.' }
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
    params.require(:instrument).permit(:title, :category, :tags)
  end
end
