# frozen_string_literal: true

class ImageUploader < BaseUploader
  attr_accessor :prefecture_name, :city_name, :taken_date_time

  # exif情報を取得し都道府県市町村撮影日時のデータを取得する
  require 'exifr/jpeg'
  process :exif_info
  def exif_info
    exif = EXIFR::JPEG.new(file.file)
    latitude = exif.gps.latitude
    longitude = exif.gps.longitude
    @taken_date_time = exif.date_time
    result = Geocoder.search("#{latitude},#{longitude}").first
    if result

      @prefecture_name = result.data['address_components'].filter_map { |component|
        component['long_name'] if component['types'].include?('administrative_area_level_1')
      }.first
      gun_name = result.data['address_components'].filter_map { |component|
        component['long_name'] if component['types'].include?('administrative_area_level_2')
      }.first
      @city_name = result.data['address_components'].filter_map { |component|
        component['long_name'] if component['types'].include?('locality') || component['types'].include?('town') || component['types'].include?('village')
      }.join('')
      @city_name = "#{gun_name}#{@city_name}" if gun_name

    end
  rescue StandardError => e
    Rails.logger.error "Error processing EXIF info: #{e.message}"
  end
end
