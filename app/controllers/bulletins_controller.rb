class BulletinsController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  NUM_PER_PAGE = 15.to_f

  # GET /bulletins
  # GET /bulletins.json
  def index
    @offset = params[:page].nil? ? 0 : NUM_PER_PAGE * (params[:page].to_i - 1)
    if params[:search].nil?
      count = Bulletin.count
      @pages = (count / NUM_PER_PAGE).ceil
      @bulletins = Bulletin.limit(NUM_PER_PAGE).offset(@offset).order(updated_at: :desc)
    else
      count = Bulletin.where(title: /.*#{params[:search]}.*/i).count
      @pages = (count / NUM_PER_PAGE).ceil
      @bulletins = Bulletin.where(title: /.*#{params[:search]}.*/i)
                    .limit(NUM_PER_PAGE).offset(@offset).order(updated_at: :desc)
    end
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
        format.html { redirect_to @bulletin, notice: 'bulletin was successfully created.' }
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
        format.html { redirect_to @bulletin, notice: 'Bulletin was successfully updated.' }
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
      format.html { redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.' }
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
    params.require(:bulletin).permit(:title, :content)
  end
end
