# frozen_string_literal: true

puts 'Start inserting Insects data'

# https://konchu-zukan.info/japanese_syllabary.php
insects = [
  { name: 'アオスジアゲハ', size:"55～65mm", lifespan:"2週間〜1ヶ月", biological_family_id: 2,habitat_place_id: 3},
  { name: 'アオタテハモドキ',  size:"55～60mm", lifespan:"2週間〜3ヶ月",biological_family_id: 30,habitat_place_id:1 },
  { name: 'アオハダトンボ', size:"55mm", lifespan:"2ヶ月", biological_family_id: 15,habitat_place_id:2 },
  { name: 'アオマツムシ',  size:"24mm", lifespan:"3ヶ月",biological_family_id: 20,habitat_place_id: 1},
  { name: 'アカシジミ',  size:"35～45mm", lifespan:"1ヶ月",biological_family_id: 23,habitat_place_id:1 },
  { name: 'アカタテハ',  size:"50~60mm", lifespan:"4〜6ヶ月",biological_family_id: 30,habitat_place_id: 1},
  { name: 'アカハナカミキリ', size:"12~22mm", lifespan:"2〜4ヶ月",biological_family_id: 13,habitat_place_id:3 },
  { name: 'アキアカネ',  size:"40mm", lifespan:"3〜4ヶ月",biological_family_id: 35,habitat_place_id: 2},
  { name: 'アサギマダラ',  size:"100mm", lifespan:"4〜5ヶ月",biological_family_id: 42,habitat_place_id:1 },
  { name: 'アブラゼミ',  size:"50～60mm", lifespan:"2〜3週間",biological_family_id: 29,habitat_place_id:3 },
  { name: 'アメンボ', size:"11～16mm", lifespan:"1〜3ヶ月", biological_family_id: 3,habitat_place_id: 2},
  { name: 'イシガケチョウ', size:"45～55mm", lifespan:"2〜3ヶ月",biological_family_id: 30,habitat_place_id:1 },
  { name: 'イチモンジセセリ', size:"34～45mm", lifespan:"1〜2ヶ月", biological_family_id: 28,habitat_place_id:1 },
  { name: 'エンマコオロギ', size:"23～32mm", lifespan:"1〜2ヶ月", biological_family_id: 20,habitat_place_id: 1},
  { name: 'オオウラギンスジヒョウモン', size:"60～75mm", lifespan:"2〜3ヶ月", biological_family_id: 30 ,habitat_place_id:1},
  { name: 'オオクワガタ', size:"30～78mm", lifespan:"2〜3年", biological_family_id: 19,habitat_place_id:3 },
  { name: 'オオゴマダラ',  size:"120mm", lifespan:"4〜5ヶ月",biological_family_id: 42 ,habitat_place_id:3},
  { name: 'オオスズメバチ', size:"30～45mm", lifespan:"1ヶ月〜1年", biological_family_id: 27 ,habitat_place_id:3},
  { name: 'オオゾウムシ',  size:"12～24mm", lifespan:"1年",biological_family_id: 8 ,habitat_place_id:3},
  { name: 'オオムラサキ', size:"75～100mm", lifespan:"1ヶ月", biological_family_id: 30 ,habitat_place_id:3},
  { name: 'オトシブミ', size:"7～10mm", lifespan:"1.5ヶ月", biological_family_id: 10 ,habitat_place_id:3},
  { name: 'オニヤンマ', size:"95～100mm", lifespan:"1〜2ヶ月", biological_family_id: 11 ,habitat_place_id:2},
  { name: 'オンブバッタ', size:"25～45mm", lifespan:"3ヶ月", biological_family_id: 12 ,habitat_place_id:1},
  { name: 'カナブン',  size:"23～29mm", lifespan:"1〜2ヶ月",biological_family_id: 21 ,habitat_place_id:3},
  { name: 'カブトムシ', size:"30～53mm", lifespan:"1〜3ヶ月", biological_family_id: 21 ,habitat_place_id:3},
  { name: 'カラスアゲハ', size:"80～120mm", lifespan:"1〜2週間", biological_family_id: 2 ,habitat_place_id:3},
  { name: 'カンタン', size:"12mm", lifespan:"2〜3ヶ月", biological_family_id: 20 ,habitat_place_id:1},
  { name: 'キリギリス', size:"35mm", lifespan:"2〜3ヶ月", biological_family_id: 17 ,habitat_place_id:1},
  { name: 'ギンヤンマ', size:"70mm", lifespan:"2〜3ヶ月", biological_family_id: 46,habitat_place_id:2 },
  { name: 'クマゼミ', size:"60～70mm", lifespan:"2〜3週間", biological_family_id: 29,habitat_place_id: 3},
  { name: 'クマバチ',  size:"23mm", lifespan:"1年",biological_family_id: 22 ,habitat_place_id:3},
  { name: 'クロアゲハ', size:"80～120mm", lifespan:"2〜3週間", biological_family_id: 2 ,habitat_place_id:2},
  { name: 'ゲンジボタル', size:"12～18mm", lifespan:"1〜2週間", biological_family_id: 41 ,habitat_place_id:2},
  { name: 'コクワガタ',  size:"16~45mm", lifespan:"1〜2年",biological_family_id: 19 ,habitat_place_id:3},
  { name: 'ゴマダラカミキリ', size:"25～35mm", lifespan:"3〜4ヶ月", biological_family_id: 13 ,habitat_place_id:3},
  { name: 'シオカラトンボ', size:"50~55mm", lifespan:"1〜2ヶ月", biological_family_id: 35 ,habitat_place_id:2},
  { name: 'ショウリョウバッタ', size:"45~90mm", lifespan:"4〜5ヶ月", biological_family_id: 37 ,habitat_place_id:1},
  { name: 'トノサマバッタ', size:"45~50mm", lifespan:"3〜4ヶ月", biological_family_id: 37,habitat_place_id: 1},
  { name: 'ナミテントウ',  size:"8mm", lifespan:"2〜3ヶ月",biological_family_id: 34 ,habitat_place_id:1},
  { name: 'ノコギリクワガタ',  size:"24～71mm", lifespan:"3〜4ヶ月",biological_family_id: 19 ,habitat_place_id:3},
  { name: 'ハンミョウ',  size:"20mm", lifespan:"3〜4ヶ月",biological_family_id: 39 ,habitat_place_id:4},
  { name: 'マイマイカブリ', size:"40～65mm", lifespan:"2〜4年", biological_family_id: 9 ,habitat_place_id:3},
  { name: 'ミヤマクワガタ',  size:"25~79mm", lifespan:"3ヶ月",biological_family_id: 19 ,habitat_place_id:3},
  { name: 'ミンミンゼミ',  size:"60mm", lifespan:"2～3週間",biological_family_id: 29 ,habitat_place_id:3},
  { name: 'ヤマトシジミ', size:"20～29mm", lifespan:"1ヶ月", biological_family_id: 23 ,habitat_place_id:1},
  { name: 'リュウキュウアサギマダラ', size:"70~85mm", lifespan:"1～3ヶ月", biological_family_id: 30 ,habitat_place_id:1},
  { name: 'ルリタテハ',  size:"50～65mm", lifespan:"6ヶ月",biological_family_id: 30 ,habitat_place_id:1},

]
sorted_data = insects.sort_by { |insect| [insect[:name], insect[:sex]] }
sorted_data.each do |data|
  Insect.create!(data)
end

puts 'Insects data created!'
