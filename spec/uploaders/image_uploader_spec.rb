# frozen_string_literal: true

require 'rails_helper'
require 'exifr/jpeg'

RSpec.describe ImageUploader do
  let(:image) { create(:collected_insect_image) }
  let(:uploader) { ImageUploader.new(image, :image_file) }
  let(:file_path) { Rails.public_path.join('images/exif_test_image.jpg') }
  let(:file) { File.open(file_path) }

  before do
    uploader.store!(file)
  end

  after do
    uploader.remove!
  end

  it '正しい地理的情報を取得できること' do
    exif_data = EXIFR::JPEG.new(file_path.to_s)

    # EXIFから取得した緯度経度を基に地理情報を検索する処理を模擬
    geocode_result = instance_double('GeocodeResult', data: { 'address' => { 'province' => '岡山県', 'city' => '岡山市' } })
    # uploader.exif_infoで取得した緯度経度がexif_data.gps.latitude, exif_data.gps.longitudeと一致したらgeocode_resultを返す
    allow(Geocoder).to receive(:search).with([exif_data.gps.latitude, exif_data.gps.longitude].join(',')).and_return([geocode_result])

    # 実際にEXIF情報から地理情報を取得するメソッドを呼び出す
    uploader.exif_info

    expect(uploader.prefecture_name).to eq('岡山県')
    expect(uploader.city_name).to eq('岡山市')
    expect(uploader.taken_at).to eq(exif_data.date_time)
  end
end
