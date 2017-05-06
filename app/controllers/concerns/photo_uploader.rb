
class PhotoUploader < CarrierWave::Uploader::Base
  included CarrierWave::MiniMagick
  storage :file
  process resize_to_limit: [640, nil]

  def store_dir
    "photos/"
  end

  def filename
    if super.present?
      @name ||= Digest::MD5.hexdigest(current_path)
      "#{Time.now.year}/#{@name}.#{file.extension.downcase}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end