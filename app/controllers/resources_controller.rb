class ResourcesController < ApplicationController
  load_and_authorize_resource

  def index
    parent = params[:parent]
    res = Resource
    if parent.nil? or parent == ''
      @resources = res.where(parent: nil)
    else
      @resources = res.where(parent: parent)
    end
    @parent = Resource.where(id: parent).first
    @resource = Resource.new(parent: parent)
  end

  def create
    @resource = Resource.new(resource_params)
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

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:resource)
      .permit(:title, :parent, :is_folder, :document)
  end

end
