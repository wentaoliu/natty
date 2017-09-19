class ForumsController < ApplicationController
  #load_and_authorize_resource
  before_action :set_forum, only: [:show, :destroy]

  # GET /forums
  # GET /forums.json
  def index
    res = can?(:create, Forum) ? Forum : Forum.where(hidden: false)
    @forums = res.order(updated_at: :desc)
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    @forum.inc(hits: 1)
    @comment = Comment.new
  end

  # GET /forums/new
  def new
    @forum = Forum.new
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(forum_params)
    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum, notice: t('.success') }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_forum
    @forum = Forum.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def forum_params
    params.require(:forum).permit(:name, :description, :hidden)
  end
end
