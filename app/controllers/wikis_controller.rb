class WikisController < ApplicationController
  load_and_authorize_resource
  before_action :set_wiki, only: [:show, :edit, :update, :destroy, :versions]

  NUM_PER_PAGE = 15

  # GET /wikis
  # GET /wikis.json
  def index
    res = can?(:create, Wiki) ? Wiki : Wiki.where(hidden: false)
    if params[:search].present?
      res = res.where(title: /.*#{params[:search]}.*/i)
    end
    @wikis = res.order(updated_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /wikis/1
  # GET /wikis/1.json
  def show
    @wiki = @wiki.versions.where(version: params[:version]).first if params[:version]
  end

  # GET /wikis/new
  def new
    @wiki = Wiki.new
  end

  # GET /wikis/1/edit
  def edit
  end

  # POST /wikis
  # POST /wikis.json
  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    respond_to do |format|
      if @wiki.save
        format.html { redirect_to @wiki, notice: t('.success') }
        format.json { render :show, status: :created, location: @wiki }
      else
        format.html { render :new }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wikis/1
  # PATCH/PUT /wikis/1.json
  def update
    respond_to do |format|
      if @wiki.update(wiki_params)
        format.html { redirect_to @wiki, notice: t('.success') }
        format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wikis/1
  # DELETE /wikis/1.json
  def destroy
    @wiki.destroy
    respond_to do |format|
      format.html { redirect_to wikis_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  def versions

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_wiki
    @wiki = Wiki.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wiki_params
    params.require(:wiki).permit(:title, :content, :comment, :hidden)
  end
end
