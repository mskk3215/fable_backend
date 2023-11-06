# frozen_string_literal: true

puts 'Start inserting Biological_families data'

biological_families = [
{ name: 'アオイトトンボ科'},
{ name: 'アゲハチョウ科'},
{ name: 'アメンボ科'},
{ name: 'アリ科'},
{ name: 'イエバエ科'},
{ name: 'イナゴ科'},
{ name: 'ウスバカゲロウ科'},
{ name: 'オオゾウムシ科'},
{ name: 'オサムシ科'},
{ name: 'オトシブミ科'},
{ name: 'オニヤンマ科'},
{ name: 'オンブバッタ科'},
{ name: 'カミキリムシ科'},
{ name: 'カメムシ科'},
{ name: 'カワトンボ科'},
{ name: 'カ科'},
{ name: 'キリギリス科'},
{ name: 'クサカゲロウ科'},
{ name: 'クワガタムシ科'},
{ name: 'コオロギ科'},
{ name: 'コガネムシ科'},
{ name: 'コシブトハナバチ科'},
{ name: 'シジミチョウ科'},
{ name: 'シリアゲムシ科'},
{ name: 'シロチョウ科'},
{ name: 'スズメガ科'},
{ name: 'スズメバチ科'},
{ name: 'セセリチョウ科'},
{ name: 'セミ科'},
{ name: 'タテハチョウ科'},
{ name: 'タマムシ科'},
{ name: 'ツチバチ科'},
{ name: 'ツチハンミョウ科'},
{ name: 'テントウムシ科'},
{ name: 'トンボ科'},
{ name: 'ハキリバチ科'},
{ name: 'バッタ科'},
{ name: 'ハナアブ科'},
{ name: 'ハンミョウ科'},
{ name: 'ヘビトンボ科'},
{ name: 'ホタル科'},
{ name: 'マダラチョウ科'},
{ name: 'ミツバチ科'},
{ name: 'ムシヒキアブ科'},
{ name: 'ヤママユガ科'},
{ name: 'ヤンマ科'},
{ name: 'ヨコバイ科'},
]

# データベースに保存
biological_families.each do |family|
  BiologicalFamily.create!(family)
end


puts 'Biological_families data created!'
