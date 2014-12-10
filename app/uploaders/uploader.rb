class Uploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file
  process :resize_to_fit => [300, 300]

  version :thumb do
    process :resize_to_fill => [200,200]
  end

  def store_dir
    'photos'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # def cache_dir
  #   '/-cache'
  # end


end