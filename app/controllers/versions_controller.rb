class VersionsController < ApplicationController
  #load_and_authorize_resource
  before_action :set_wiki
  before_action :set_version, only: [:show, :update]

  # GET /versions
  # GET /versions.json
  def index
    @versions = @wiki.versions
  end

  # GET /versions/1
  # GET /versions/1.json
  def show
  end

  # PATCH/PUT /versions/1
  # PATCH/PUT /versions/1.json
  def update
    respond_to do |format|
      if @version.rollback
        format.html { redirect_to @wiki, notice: t('.success') }
        format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def set_version
    @version = @wiki.versions.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wiki_params
    params.require(:wiki).permit(:title, :content, :comment, :hidden)
  end
end
