class WikisController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]
  before_action :set_wiki, only: [:show, :edit, :update, :destroy, :versions]

  NUM_PER_PAGE = 15.to_f

  # GET /wikis
  # GET /wikis.json
  def index
    @offset = params[:page].nil? ? 0 : NUM_PER_PAGE * (params[:page].to_i - 1)
    if params[:search].nil?
      count = Wiki.count
      @pages = (count / NUM_PER_PAGE).ceil
      @wikis = Wiki.limit(NUM_PER_PAGE).offset(@offset)
    else
      count = Wiki.where(title: /.*#{params[:search]}.*/i).count
      @pages = (count / NUM_PER_PAGE).ceil
      @wikis = Wiki.where(title: /.*#{params[:search]}.*/i)
                .limit(@per_page).offset(@offset)
    end
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
    params.require(:wiki).permit(:title, :content, :comment)
  end
end
