class BulletinsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /bulletins
  # GET /bulletins.json
  def index
    res = can?(:create, Bulletin) ? Bulletin : Bulletin.where(hidden: false)
    if params[:search].present?
      res = res.where(title: /.*#{params[:search]}.*/i)
    end
    @bulletins = res.order(updated_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /bulletin/1
  # GET /bulletin/1.json
  def show
    if /[\d]/.match(params[:id])
      @bulletin = Bulletin.find(params[:id])
    else
      @bulletin = Bulletin.find_by(title: params[:id])
    end
  end

  # GET /bulletin/new
  def new
    @bulletin = Bulletin.new
  end

  # GET //edit
  def edit
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)
    @bulletin.user = current_user
    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to @bulletin, notice: t('.success') }
        format.json { render :show, status: :created, location: @bulletin }
      else
        format.html { render :new }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /admin/introduction/update/:id
  def update
    respond_to do |format|
      if @bulletin.update(bulletin_params)
        format.html { redirect_to @bulletin, notice: t('.success') }
        format.json { render :show, status: :ok, location: @bulletin }
      else
        format.html { render :edit }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletin/1
  # DELETE /bulletin/1.json
  def destroy
    @bulletin.destroy
    respond_to do |format|
      format.html { redirect_to bulletins_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @bulletin = Bulletin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bulletin_params
    params.require(:bulletin).permit(:title, :content, :hidden)
  end
end
