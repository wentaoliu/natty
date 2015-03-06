class ResourcesController < ApplicationController
  include Uploader

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

  def show
    resource = Resource.find(params[:id])
    send_file("#{Rails.root}/public/uploads/files/#{resource.filename}",
              filename: "#{resource.filename}")
  end

  def create
    if params[:resource][:is_folder] == true
      @resource = Resource.new(params.require(:resource)
                    .permit(:title, :parent, :is_folder))
    else
      @resource = Resource.new(params.require(:resource)
                    .permit(:title, :parent, :public, :is_folder))
      file = params[:resource][:file]
      if file.is_a? ActionDispatch::Http::UploadedFile
        @resource.filename = save_file_local(file)
      end
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

  private

  def allowed_file(filename)
    #return filename.include?('.') and
    #  ALLOWED_EXTENSIONS.include?(filename.split('.')[-1].downcase)
  end

end
