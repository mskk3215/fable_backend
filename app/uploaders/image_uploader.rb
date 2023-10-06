# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  attr_accessor :prefecture_name, :city_name, :taken_at

  # Choose what kind of storage to use for this uploader:
  if production?
    storage :fog
  else
    storage :file
  end

  def asset_host
    'http://localhost:3001'
  end

  # exif情報を取得し都道府県市町村撮影日のデータを取得する
  require 'exifr/jpeg'
  process :exif_info
  def exif_info
    exif = EXIFR::JPEG.new(file.file)
    latitude = exif.gps.latitude
    longitude = exif.gps.longitude
    @taken_at = exif.date_time

    result = Geocoder.search("#{latitude},#{longitude}").first
    if result
      @prefecture_name = result.data['address']['province']
      @city_name = %w[city town village].filter_map { |type| result.data['address'][type] }.join('')
    end
  rescue StandardError => e
    Rails.logger.error "Error processing EXIF info: #{e.message}"
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process resize_to_fit: [1000, 1000]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :post do
    process resize_to_fit: [1000, 1000]
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w[jpg jpeg gif png heif heic]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
