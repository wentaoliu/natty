class BookingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_instrument
  before_action :set_booking, only: [:show, :destroy]

  NUM_PER_PAGE = 15

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.order(updated_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = @instrument.bookings.new(booking_params)
    @booking.user = current_user
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: t('.success') }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookings
  def update
    respond_to do |format|
      if @booking.update(booking_params)

        format.html { redirect_to @booking, notice: t('.success') }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at, :record)
  end

end
