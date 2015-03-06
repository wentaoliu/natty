module Uploader

  ALLOWED_EXTENSIONS = %w( txt, pdf, png, jpg, jpeg, gif, rar, zip )

  # 将文件保存至本地
  def save_file_local(file)
    if !file.original_filename.empty?

      filename=file.original_filename

      # 检查目录是否存在，若不存在则创建目录
      if File.directory? "#{Rails.root}/public/uploads"
        if !File.directory? "#{Rails.root}/public/uploads/files"
          Dir.mkdir("#{Rails.root}/public/uploads/files")
        end
      else
        Dir.mkdir("#{Rails.root}/public/uploads")
        Dir.mkdir("#{Rails.root}/public/uploads/files")
      end

      # 存入以下目录
      url="/uploads/files/#{filename}"

      File.open("#{Rails.root}/public#{url}", "wb") do |f|
        f.write(file.read)
      end

      # 返回相对目录路径
      return filename
    else
      return nil
    end
  end
end
