class EquipmentsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /equipments
  # GET /equipments.json
  def index
    @offset = params[:page].nil? ? 0 : NUM_PER_PAGE * (params[:page].to_i - 1)
    if params[:search].nil?
      count = Equipment.count
      @pages = (count / NUM_PER_PAGE).ceil
      @equipments = Equipment.limit(NUM_PER_PAGE).offset(@offset)
    else
      count = Equipment.where("title LIKE ?", "%#{params[:search]}%").count
      @pages = (count / NUM_PER_PAGE).ceil
      @equipments = Equipment.where("title LIKE ?", "%#{params[:search]}%").limit(NUM_PER_PAGE).offset(@offset)
    end
  end

  # GET /equipments/1
  # GET /equipments/1.json
  def show
    @article = @equipment.articles.order(created_at: :desc).first()
  end

  # GET /equipments/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipments/1/edit
  def edit
  end

  # POST /equipments
  # POST /equipments.json
  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to new_equipment_article_path(@equipment),
                      notice: 'Equipment was successfully created.' }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipments/1
  # PATCH/PUT /equipments/1.json
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

  # DELETE /equipments/1
  # DELETE /equipments/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to equipments_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def equipment_params
    params.require(:equipment).permit(:title, :category, :tags)
  end
end
