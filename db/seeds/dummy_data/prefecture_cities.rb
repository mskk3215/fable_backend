# frozen_string_literal: true

puts 'Start inserting prefecture and city data...'

require 'net/http'
require 'zip'

PREF_CITY_URL = URI.parse('https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip')
SAVEDIR = 'db/'
CSVROW_PREFNAME = 6
CSVROW_CITYNAME = 7
save_path = ''

# 都道府県・市区町村ZIPをダウンロード
response = Net::HTTP.get_response(PREF_CITY_URL)

# ダウンロードしたデータをバッファに読み込み、ZIPファイルとして処理
Zip::File.open_buffer(response.body) do |zf|
  zf.each do |entry|
    save_path = SAVEDIR + entry.name
    zf.extract(entry, save_path) { true }
  end
end

# 都道府県・市区町村CSVを読み込みテーブルに保存
CSV.foreach(save_path, encoding: 'Shift_JIS:UTF-8') do |row|
  pref_name = row[CSVROW_PREFNAME]
  city_name = row[CSVROW_CITYNAME]
  pref = Prefecture.find_or_create_by(name: pref_name)
  City.find_or_create_by(name: city_name, prefecture_id: pref.id)
end

# 保存したCSVファイルを削除
File.unlink save_path

puts 'prefecture and city data created!'
