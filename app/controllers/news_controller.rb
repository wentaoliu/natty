class NewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  NUM_PER_PAGE = 15

  # GET /news
  # GET /news.json
  def index
    res = can?(:create, News) ? News : News.where(hidden: false)
    if params[:search].present?
      res = res.where(title: /.*#{params[:search]}.*/i)
    end
    @news = res.order(created_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news.inc(hits: 1)
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)
    @news.user = current_user
    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: t('.success') }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: t('.success') }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_news
    @news = News.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def news_params
    params.require(:news).permit(:title, :content, :hidden)
  end
end
