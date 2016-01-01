class TopicsController < ApplicationController
  load_and_authorize_resource
  before_action :set_topic, only: [:show, :destroy]

  NUM_PER_PAGE = 15

  # GET /topics
  # GET /topics.json
  def index
    res = can?(:create, Topic) ? Topic : Topic.where(hidden: false)
    if params[:search].present?
      res = res.where(title: /.*#{params[:search]}.*/i)
    end
    @topics = res.order(updated_at: :desc).page(params[:page]).per(NUM_PER_PAGE)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic.inc(hits: 1)
    @comment = Comment.new
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.tags = params[:topic][:tags].split('/')
    @topic.user = current_user
    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: t('.success') }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def topic_params
    params.require(:topic).permit(:title, :content, :category, :hidden)
  end
end
