class ResourcesController < ApplicationController
  before_filter :require_signin
  before_filter :require_admin, only: [:destroy]

  def index
    parent = params[:parent]
    if parent.nil? or parent == ''
      @resources = Resource.where(parent: nil)
    else
      @resources = Resource.where(parent: parent)
    end
    @parent = Resource.where(id: parent).first
    @resource = Resource.new(parent: parent)
  end

  def create
    if params[:resource][:is_folder] == true
      @resource = Resource.new(params.require(:resource)
                    .permit(:title, :parent, :is_folder))
    else
      @resource = Resource.new(params.require(:resource)
                    .permit(:title, :parent, :public, :is_folder, :document))
    end
    @resource.user = current_user
    respond_to do |format|
      if @resource.save
        format.html { redirect_to resources_path(parent: params[:resource][:parent]),
                      notice: t('.success') }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

end
