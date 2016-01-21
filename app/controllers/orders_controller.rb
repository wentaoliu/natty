class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /orders
  # GET /orders.json
  def index
    res = can?(:create, Order) ? Order : Order.where(hidden: false)
    if params[:search].present?
      res = res.where(title: /.*#{params[:search]}.*/i)
    end
    @orders = res.order(updated_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /order/1
  # GET /order/1.json
  def show
  end

  # GET /order/new
  def new
    @order = Order.new
  end

  # GET //edit
  def edit
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: t('.success') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /admin/introduction/update/:id
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: t('.success') }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order/1
  # DELETE /order/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:title, :quantity, :unit_size, :unit_price,
      :total_price, :bought_from, :type, :vendor_name, :invoice, :notes, :hidden)
  end
end
