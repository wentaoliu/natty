class TopicsController < ApplicationController
  before_filter :require_signin
  skip_before_filter :require_signin, only: [:index, :show], if: :format_json?
  before_filter :require_admin, only: [:destroy]
  before_action :set_topic, only: [:show, :destroy]

  NUM_PER_PAGE = 15

  # GET /topics
  # GET /topics.json
  def index
    @offset = params[:page].nil? ? 0 : NUM_PER_PAGE * (params[:page].to_i - 1)
    if params[:search].nil?
      count = Topic.count
      @pages = (count / NUM_PER_PAGE).ceil
      @topics = Topic.limit(NUM_PER_PAGE).offset(@offset).order(updated_at: :desc)
    else
      count = Topic.where(title: /.*#{params[:search]}.*/i).count
      @pages = (count / NUM_PER_PAGE).ceil
      @topics = Topic.where(title: /.*#{params[:search]}.*/i)
                  .limit(NUM_PER_PAGE).offset(@offset).order(updated_at: :desc)
    end
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
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
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
      format.html { redirect_to topics_url, notice: 'User was successfully destroyed.' }
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
    params.require(:topic).permit(:title, :content, :category)
  end
end
