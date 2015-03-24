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
    # Attempt to save into the datebase
    @resource.save
    # Handle a successful save
    redirect_to resources_path(parent: params[:resource][:parent])
  end

  def destroy
    @resource = Resource.find(params[:id])
    #redirect_to :action=>'index' and return false if @resource==nil
    #access_denied unless @resource.author == current_user.username or admin?
    @resource.destroy
    redirect_to resources_path
  end

end
