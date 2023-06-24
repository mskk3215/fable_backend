# frozen_string_literal: true

puts 'Start inserting Parks data'

parks = [
  { name: '高尾山', post_code: '193-0844', address: '東京都八王子市高尾町', latitude: 35.625412, longitude: 139.243739, city_id: 678,
    prefecture_id: 13 },
  { name: '井の頭恩賜公園', post_code: '180-0005', address: '東京都武蔵野市御殿山1-18-31', latitude: 35.699748, longitude: 139.573702,
    city_id: 680, prefecture_id: 13 },
  { name: 'グリーントリム公園', post_code: '205-0017', address: '東京都羽村市羽西1-2', latitude: 35.770999, longitude: 139.302748,
    city_id: 701, prefecture_id: 13 },
  { name: '等々力渓谷', post_code: '158-0091', address: '東京都世田谷区等々力1-22', latitude: 35.605444, longitude: 139.645602,
    city_id: 666, prefecture_id: 13 },
  { name: '東村山中央公園', post_code: '189-0024', address: '東京都東村山市富士見町5丁目4-27', latitude: 35.747666, longitude: 139.459178,
    city_id: 690, prefecture_id: 13 },
  { name: '石神井公園', post_code: '177-0045', address: '東京都練馬区石神井台1丁目26-1', latitude: 35.737959, longitude: 139.598994,
    city_id: 674, prefecture_id: 13 },
  { name: '長沼公園', post_code: '192-0907', address: '東京都八王子市長沼町', latitude: 35.638301, longitude: 139.368525,
    city_id: 678, prefecture_id: 13 },
  { name: '小金井公園', post_code: '184-0001', address: '東京都小金井市関野町1-13-1', latitude: 35.71656, longitude:  139.517711,
    city_id: 687, prefecture_id: 13 },
  { name: '神代植物公園', post_code: '182-0017', address: '東京都調布市深大寺元町5丁目5-31-10', latitude: 35.671281, longitude: 139.548348,
    city_id: 685, prefecture_id: 13 },
  { name: '玉川上水緑道', post_code: '168-0082', address: '東京都杉並区久我山1丁目6', latitude: 35.724312, longitude: 139.423727,
    city_id: 669, prefecture_id: 13 },
  { name: '林試の森公園', post_code: '142-0061', address: '東京都品川区小山台2丁目6', latitude: 35.625032, longitude: 139.703267,
    city_id: 663, prefecture_id: 13 },
  { name: '成城三丁目緑地', post_code: '157-0066', address: '東京都世田谷区成城3丁目16-38', latitude: 35.634179, longitude: 139.59973,
    city_id: 666, prefecture_id: 13 },
  { name: '江古田の森公園', post_code: '165-0022', address: '東京都中野区江古田3丁目14番', latitude: 35.730896, longitude: 139.665864,
    city_id: 668, prefecture_id: 13 },
  { name: '砧公園・きぬた公園', post_code: '157-0075', address: '東京都世田谷区砧公園1-1', latitude: 35.634207, longitude: 139.616582,
    city_id: 666, prefecture_id: 13 },
  { name: '光が丘公園', post_code: '179-0072', address: '東京都練馬区光が丘4丁目1-1', latitude: 35.766377, longitude: 139.629484,
    city_id: 674, prefecture_id: 13 }
]

parks.each do |park|
  Park.create!(park)
end

puts 'Parks data created!'
