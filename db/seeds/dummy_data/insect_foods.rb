# frozen_string_literal: true

puts 'Start inserting InsectFoods data'

insect_foods = [
  { insect_id: 1, food_id: 3 }, # アオスジアゲハ
  { insect_id: 2, food_id: 3 }, # アオタテハモドキ
  { insect_id: 3, food_id: 13 }, # アオハダトンボ
  { insect_id: 4, food_id: 13 }, # アオマツムシ
  { insect_id: 5, food_id: 10 }, # アカシジミ
  { insect_id: 6, food_id: 2 }, # アカタテハ
  { insect_id: 6, food_id: 3 },
  { insect_id: 7, food_id: 3 }, # アカハナカミキリ
  { insect_id: 7, food_id: 4 },
  { insect_id: 8, food_id: 13 }, # アキアカネ
  { insect_id: 9, food_id: 3 }, # アサギマダラ
  { insect_id: 10, food_id: 10 }, # アブラゼミ
  { insect_id: 11, food_id: 14 }, # アメンボ
  { insect_id: 12, food_id: 2 }, # イシガケチョウ
  { insect_id: 12, food_id: 10 },
  { insect_id: 13, food_id: 3 }, # イチモンジセセリ
  { insect_id: 14, food_id: 1 }, # エンマコオロギ
  { insect_id: 14, food_id: 5 },
  { insect_id: 14, food_id: 6 },
  { insect_id: 15, food_id: 3 }, # オオウラギンスジヒョウモン
  { insect_id: 16, food_id: 2 }, # オオクワガタ
  { insect_id: 16, food_id: 10 },
  { insect_id: 17, food_id: 3 }, # オオゴマダラ
  { insect_id: 18, food_id: 1 }, # オオスズメバチ
  { insect_id: 18, food_id: 14 },
  { insect_id: 19, food_id: 6 }, # オオゾウムシ
  { insect_id: 19, food_id: 7 },
  { insect_id: 20, food_id: 2 }, # オオムラサキ
  { insect_id: 20, food_id: 10 },
  { insect_id: 21, food_id: 5 }, # オトシブミ
  { insect_id: 22, food_id: 13 }, # オニヤンマ
  { insect_id: 23, food_id: 5 }, # オンブバッタ
  { insect_id: 24, food_id: 1 }, # カナブン
  { insect_id: 24, food_id: 10 },
  { insect_id: 25, food_id: 1 }, # カブトムシ
  { insect_id: 25, food_id: 10 },
  { insect_id: 26, food_id: 3 }, # カラスアゲハ
  { insect_id: 27, food_id: 5 }, # カンタン
  { insect_id: 27, food_id: 8 },
  { insect_id: 27, food_id: 9 },
  { insect_id: 28, food_id: 5 }, # キリギリス
  { insect_id: 28, food_id: 9 },
  { insect_id: 28, food_id: 14 },
  { insect_id: 29, food_id: 13 }, # ギンヤンマ
  { insect_id: 30, food_id: 10 }, # クマゼミ
  { insect_id: 31, food_id: 3 }, # クマバチ
  { insect_id: 31, food_id: 4 },
  { insect_id: 32, food_id: 3 }, # クロアゲハ
  { insect_id: 33, food_id: 17 }, # ゲンジボタル
  { insect_id: 34, food_id: 1 }, # コクワガタ
  { insect_id: 34, food_id: 10 },
  { insect_id: 35, food_id: 5 }, # ゴマダラカミキリ
  { insect_id: 35, food_id: 11 },
  { insect_id: 36, food_id: 13 }, # シオカラトンボ
  { insect_id: 37, food_id: 5 }, # ショウリョウバッタ
  { insect_id: 38, food_id: 5 }, # トノサマバッタ
  { insect_id: 39, food_id: 5 }, # ナミテントウ
  { insect_id: 39, food_id: 14 },
  { insect_id: 39, food_id: 15 },
  { insect_id: 40, food_id: 1 }, # ノコギリクワガタ
  { insect_id: 40, food_id: 10 },
  { insect_id: 41, food_id: 14 }, # ハンミョウ
  { insect_id: 42, food_id: 14 }, # マイマイカブリ
  { insect_id: 42, food_id: 16 },
  { insect_id: 43, food_id: 1 }, # ミヤマクワガタ
  { insect_id: 43, food_id: 10 },
  { insect_id: 44, food_id: 10 }, # ミンミンゼミ
  { insect_id: 45, food_id: 3 }, # ヤマトシジミ
  { insect_id: 46, food_id: 3 }, # リュウキュウアサギマダラ
  { insect_id: 47, food_id: 2 }, # ルリタテハ
  { insect_id: 47, food_id: 10 }
]

insect_foods.each do |insect_food|
  InsectFood.create!(insect_food)
end

puts 'InsectFoods data created!'
