# frozen_string_literal: true

puts 'Start inserting InsectFoods data'

insect_foods = [
  { insect_id: 1, food_id: 3 }, # アオスジアゲハ（オス）
  { insect_id: 2, food_id: 3 }, # アオスジアゲハ（メス）
  { insect_id: 3, food_id: 3 }, # アオタテハモドキ（オス）
  { insect_id: 4, food_id: 3 }, # アオタテハモドキ（メス）
  { insect_id: 5, food_id: 13 }, # アオハダトンボ（オス）
  { insect_id: 6, food_id: 13 }, # アオハダトンボ（メス）
  { insect_id: 7, food_id: 13 }, # アオマツムシ（オス）
  { insect_id: 8, food_id: 13 }, # アオマツムシ（メス）
  { insect_id: 9, food_id: 10 }, # アカシジミ（オス）
  { insect_id: 10, food_id: 10 }, # アカシジミ（メス）
  { insect_id: 11, food_id: 2 }, # アカタテハ（オス）
  { insect_id: 11, food_id: 3 },
  { insect_id: 12, food_id: 2 }, # アカタテハ（メス）
  { insect_id: 12, food_id: 3 },
  { insect_id: 13, food_id: 3 }, # アカハナカミキリ（オス）
  { insect_id: 13, food_id: 4 },
  { insect_id: 14, food_id: 3 }, # アカハナカミキリ（メス）
  { insect_id: 14, food_id: 4 },
  { insect_id: 15, food_id: 13 }, # アキアカネ（オス）
  { insect_id: 16, food_id: 13 }, # アキアカネ（メス）
  { insect_id: 17, food_id: 3 }, # アサギマダラ（オス）
  { insect_id: 18, food_id: 3 }, # アサギマダラ（メス）
  { insect_id: 19, food_id: 10 }, # アブラゼミ（オス）
  { insect_id: 20, food_id: 10 }, # アブラゼミ（メス）
  { insect_id: 21, food_id: 14 }, # アメンボ（オス）
  { insect_id: 22, food_id: 14 }, # アメンボ（メス）
  { insect_id: 23, food_id: 2 }, # イシガケチョウ（オス）
  { insect_id: 23, food_id: 10 },
  { insect_id: 24, food_id: 2 }, # イシガケチョウ（メス）
  { insect_id: 24, food_id: 10 },
  { insect_id: 25, food_id: 3 }, # イチモンジセセリ（オス）
  { insect_id: 26, food_id: 3 }, # イチモンジセセリ（メス）
  { insect_id: 27, food_id: 1 }, # エンマコオロギ（オス）
  { insect_id: 27, food_id: 5 },
  { insect_id: 27, food_id: 6 }, 
  { insect_id: 28, food_id: 1 }, # エンマコオロギ（メス）
  { insect_id: 28, food_id: 5 }, 
  { insect_id: 28, food_id: 6 }, 
  { insect_id: 29, food_id: 3 }, # オオウラギンスジヒョウモン（オス）
  { insect_id: 30, food_id: 3 }, # オオウラギンスジヒョウモン（メス）
  { insect_id: 31, food_id: 2 }, # オオクワガタ（オス）
  { insect_id: 31, food_id: 10 },
  { insect_id: 32, food_id: 2 }, # オオクワガタ（メス）
  { insect_id: 32, food_id: 10 },
  { insect_id: 33, food_id: 3 }, # オオゴマダラ（オス）
  { insect_id: 34, food_id: 3 }, # オオゴマダラ（メス）
  { insect_id: 35, food_id: 1 }, # オオスズメバチ（オス）
  { insect_id: 35, food_id: 14 },
  { insect_id: 36, food_id: 1 }, # オオスズメバチ（メス）
  { insect_id: 36, food_id: 14 },
  { insect_id: 37, food_id: 6 }, # オオゾウムシ（オス）
  { insect_id: 37, food_id: 7 },
  { insect_id: 38, food_id: 6 }, # オオゾウムシ（メス）
  { insect_id: 38, food_id: 7 },
  { insect_id: 39, food_id: 2 }, # オオムラサキ（オス）
  { insect_id: 39, food_id: 10 },
  { insect_id: 40, food_id: 2 }, # オオムラサキ（メス）
  { insect_id: 40, food_id: 10 },
  { insect_id: 41, food_id: 5 }, # オトシブミ（オス）
  { insect_id: 42, food_id: 5 }, # オトシブミ（メス）
  { insect_id: 43, food_id: 13 }, # オニヤンマ（オス）
  { insect_id: 44, food_id: 13 }, # オニヤンマ（メス）
  { insect_id: 45, food_id: 5 }, # オンブバッタ（オス）
  { insect_id: 46, food_id: 5 }, # オンブバッタ（メス）
  { insect_id: 47, food_id: 1 }, # カナブン（オス）
  { insect_id: 47, food_id: 10 },
  { insect_id: 48, food_id: 1 }, # カナブン（メス）
  { insect_id: 48, food_id: 10 },
  { insect_id: 49, food_id: 1 }, # カブトムシ（オス）
  { insect_id: 49, food_id: 10 },
  { insect_id: 50, food_id: 1 }, # カブトムシ（メス）
  { insect_id: 50, food_id: 10 },
  { insect_id: 51, food_id: 3 }, # カラスアゲハ（オス）
  { insect_id: 52, food_id: 3 }, # カラスアゲハ（メス）
  { insect_id: 53, food_id: 5 }, # カンタン（オス）
  { insect_id: 53, food_id: 8 }, 
  { insect_id: 53, food_id: 9 },
  { insect_id: 54, food_id: 5 }, # カンタン（メス）
  { insect_id: 54, food_id: 8 }, 
  { insect_id: 54, food_id: 9 },
  { insect_id: 55, food_id: 5 }, # キリギリス（オス）
  { insect_id: 55, food_id: 9 }, 
  { insect_id: 55, food_id: 14 },
  { insect_id: 56, food_id: 5 }, # キリギリス（メス）
  { insect_id: 56, food_id: 9 }, 
  { insect_id: 56, food_id: 14 }, 
  { insect_id: 57, food_id: 13 }, # ギンヤンマ（オス）
  { insect_id: 58, food_id: 13 }, # ギンヤンマ（メス）
  { insect_id: 59, food_id: 10 }, # クマゼミ（オス）
  { insect_id: 60, food_id: 10 }, # クマゼミ（メス）
  { insect_id: 61, food_id: 3 }, # クマバチ（オス）
  { insect_id: 61, food_id: 4 },
  { insect_id: 62, food_id: 3 }, # クマバチ（メス）
  { insect_id: 62, food_id: 4 },
  { insect_id: 63, food_id: 3 }, # クロアゲハ（オス）
  { insect_id: 64, food_id: 3 }, # クロアゲハ（メス）
  { insect_id: 65, food_id: 17 }, # ゲンジボタル（オス）
  { insect_id: 66, food_id: 17 }, # ゲンジボタル（メス）
  { insect_id: 67, food_id: 1 }, # コクワガタ（オス）
  { insect_id: 67, food_id: 10 },
  { insect_id: 68, food_id: 1 }, # コクワガタ（メス）
  { insect_id: 68, food_id: 10 },
  { insect_id: 69, food_id: 5 }, # ゴマダラカミキリ（オス）
  { insect_id: 69, food_id: 11 },
  { insect_id: 70, food_id: 5 }, # ゴマダラカミキリ（メス）
  { insect_id: 70, food_id: 11 },
  { insect_id: 71, food_id: 13 }, # シオカラトンボ（オス）
  { insect_id: 72, food_id: 13 }, # シオカラトンボ（メス）
  { insect_id: 73, food_id: 5 }, # ショウリョウバッタ（オス）
  { insect_id: 74, food_id: 5 }, # ショウリョウバッタ（メス）
  { insect_id: 75, food_id: 5 }, # トノサマバッタ（オス）
  { insect_id: 76, food_id: 5 }, # トノサマバッタ（メス）
  { insect_id: 77, food_id: 5 }, # ナミテントウ（オス）
  { insect_id: 77, food_id: 14 },
  { insect_id: 77, food_id: 15 },
  { insect_id: 78, food_id: 5 }, # ナミテントウ（メス）
  { insect_id: 78, food_id: 14 },
  { insect_id: 78, food_id: 15 },
  { insect_id: 79, food_id: 1 }, # ノコギリクワガタ（オス）
  { insect_id: 79, food_id: 10 },
  { insect_id: 80, food_id: 1 }, # ノコギリクワガタ（メス）
  { insect_id: 80, food_id: 10 },
  { insect_id: 81, food_id: 14 }, # ハンミョウ（オス）
  { insect_id: 82, food_id: 14 }, # ハンミョウ（メス）
  { insect_id: 83, food_id: 14 }, # マイマイカブリ（オス）
  { insect_id: 83, food_id: 16 },
  { insect_id: 84, food_id: 14 }, # マイマイカブリ（メス）
  { insect_id: 84, food_id: 16 },
  { insect_id: 85, food_id: 1 }, # ミヤマクワガタ（オス）
  { insect_id: 85, food_id: 10 },
  { insect_id: 86, food_id: 1 }, # ミヤマクワガタ（メス）
  { insect_id: 86, food_id: 10 },
  { insect_id: 87, food_id: 10 }, # ミンミンゼミ（オス）
  { insect_id: 88, food_id: 10 }, # ミンミンゼミ（メス）
  { insect_id: 89, food_id: 3 }, # ヤマトシジミ（オス）
  { insect_id: 90, food_id: 3 }, # ヤマトシジミ（メス）
  { insect_id: 91, food_id: 3 }, # リュウキュウアサギマダラ（オス）
  { insect_id: 92, food_id: 3 }, # リュウキュウアサギマダラ（メス）
  { insect_id: 93, food_id: 2 }, # ルリタテハ（オス）
  { insect_id: 93, food_id: 10 },
  { insect_id: 94, food_id: 2 }, # ルリタテハ（メス）
  { insect_id: 94, food_id: 10 }
]

insect_foods.each do |insect_food|
  InsectFood.create!(insect_food)
end

puts 'InsectFoods data created!'
