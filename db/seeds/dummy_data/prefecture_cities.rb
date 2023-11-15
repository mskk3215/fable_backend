# frozen_string_literal: true

puts 'Start inserting prefecture and city data...'

require 'net/http'
require 'zip'
require 'activerecord-import'

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

existing_cities = City.joins(:prefecture).pluck('cities.name', 'prefectures.name').map { |c, p| "#{c}_#{p}" }.to_set

prefectures_to_insert = []
cities_to_insert = []
BATCH_SIZE = 1000

# 都道府県・市区町村CSVを読み込みテーブルに保存
CSV.foreach(save_path, encoding: 'Shift_JIS:UTF-8').with_index do |row, index|
  pref_name = row[CSVROW_PREFNAME]
  city_name = row[CSVROW_CITYNAME]

  pref = Prefecture.find_by(name: pref_name)
  unless pref
    pref = Prefecture.new(name: pref_name)
    pref.save!
  end

  city_key = "#{city_name}_#{pref_name}"
  unless existing_cities.include?(city_key)
    city = City.new(name: city_name, prefecture: pref)
    cities_to_insert << city
    existing_cities.add(city_key)
  end

  # 一定のバッチサイズに達したらインサートして、配列を空にする
  if ((index + 1) % BATCH_SIZE).zero?
    City.import(cities_to_insert, on_duplicate_key_ignore: true)
    cities_to_insert.clear
  end
end

# 残りのデータをインサート
City.import(cities_to_insert, on_duplicate_key_ignore: true) unless cities_to_insert.empty?

# 保存したCSVファイルを削除
File.unlink save_path

puts 'prefecture and city data created!'
