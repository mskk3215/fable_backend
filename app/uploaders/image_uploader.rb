# frozen_string_literal: true

class ImageUploader < BaseUploader
  attr_accessor :prefecture_name, :city_name, :taken_at

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
end
