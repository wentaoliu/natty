class CommentsController < ApplicationController
  authorize_resource
  before_action :set_topic, only: [:create, :destroy]

  # POST /comments(.:format)
  def create
    @comment = @topic.comments.new(comment_params)
    @comment.user = current_user
    @topic.touch
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @topic, notice: t('.success') }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { redirect_to @topic }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/:topic_id/comments/:id(.:format)
  def destroy
    @topic.comments.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @topic, notice: t('.success') }
      format.json { head :no_content }
    end
    return
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :reply_to)
  end
end
