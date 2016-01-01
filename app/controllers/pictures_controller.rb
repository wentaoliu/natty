class PicturesController < ApplicationController
  def create
    @picture = Picture.new(image: params[:upload_file])
    @picture.save
    # Return the file path
    render json:{
      file_path: (ENV["RAILS_RELATIVE_URL_ROOT"]||'') + @picture.image.url(:medium)
    }
  end

end
