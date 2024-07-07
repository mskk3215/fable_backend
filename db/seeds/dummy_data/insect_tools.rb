# frozen_string_literal: true

puts 'Start inserting InsectTools data'

insect_tools = [
  { insect_id: 1, tool_id: 1 }, # アオスジアゲハ（オス）
  { insect_id: 1, tool_id: 2 },
  { insect_id: 2, tool_id: 1 }, # アオスジアゲハ（メス）
  { insect_id: 2, tool_id: 2 },
  { insect_id: 3, tool_id: 1 }, # アオタテハモドキ（オス）
  { insect_id: 3, tool_id: 2 },
  { insect_id: 4, tool_id: 1 }, # アオタテハモドキ（メス）
  { insect_id: 4, tool_id: 2 },
  { insect_id: 5, tool_id: 1 }, # アオハダトンボ（オス）
  { insect_id: 5, tool_id: 2 },
  { insect_id: 6, tool_id: 1 }, # アオハダトンボ（メス）
  { insect_id: 6, tool_id: 2 },
  { insect_id: 7, tool_id: 1 }, # アオマツムシ（オス）
  { insect_id: 7, tool_id: 2 },
  { insect_id: 8, tool_id: 1 }, # アオマツムシ（メス）
  { insect_id: 8, tool_id: 2 },
  { insect_id: 9, tool_id: 1 }, # アカシジミ（オス）
  { insect_id: 9, tool_id: 2 },
  { insect_id: 10, tool_id: 1 }, # アカシジミ（メス）
  { insect_id: 10, tool_id: 2 },
  { insect_id: 11, tool_id: 1 }, # アカタテハ（オス）
  { insect_id: 11, tool_id: 2 },
  { insect_id: 12, tool_id: 1 }, # アカタテハ（メス）
  { insect_id: 12, tool_id: 2 },
  { insect_id: 13, tool_id: 1 }, # アカハナカミキリ（オス）
  { insect_id: 13, tool_id: 2 },
  { insect_id: 13, tool_id: 4 },
  { insect_id: 14, tool_id: 1 }, # アカハナカミキリ（メス）
  { insect_id: 14, tool_id: 2 },
  { insect_id: 14, tool_id: 4 },
  { insect_id: 15, tool_id: 1 }, # アキアカネ（オス）
  { insect_id: 15, tool_id: 2 },
  { insect_id: 16, tool_id: 1 }, # アキアカネ（メス）
  { insect_id: 16, tool_id: 2 },
  { insect_id: 17, tool_id: 1 }, # アサギマダラ（オス）
  { insect_id: 17, tool_id: 2 },
  { insect_id: 18, tool_id: 1 }, # アサギマダラ（メス）
  { insect_id: 18, tool_id: 2 },
  { insect_id: 19, tool_id: 1 }, # アブラゼミ（オス）
  { insect_id: 19, tool_id: 2 },
  { insect_id: 20, tool_id: 1 }, # アブラゼミ（メス）
  { insect_id: 20, tool_id: 2 },
  { insect_id: 21, tool_id: 1 }, # アメンボ（オス）
  { insect_id: 21, tool_id: 2 },
  { insect_id: 22, tool_id: 1 }, # アメンボ（メス）
  { insect_id: 22, tool_id: 2 },
  { insect_id: 23, tool_id: 1 }, # イシガケチョウ（オス）
  { insect_id: 23, tool_id: 2 },
  { insect_id: 24, tool_id: 1 }, # イシガケチョウ（メス）
  { insect_id: 24, tool_id: 2 },
  { insect_id: 25, tool_id: 1 }, # イチモンジセセリ（オス）
  { insect_id: 25, tool_id: 2 },
  { insect_id: 26, tool_id: 1 }, # イチモンジセセリ（メス）
  { insect_id: 26, tool_id: 2 },
  { insect_id: 27, tool_id: 1 }, # エンマコオロギ（オス）
  { insect_id: 27, tool_id: 2 },
  { insect_id: 28, tool_id: 1 }, # エンマコオロギ（メス）
  { insect_id: 28, tool_id: 2 },
  { insect_id: 29, tool_id: 1 }, # オオウラギンスジヒョウモン（オス）
  { insect_id: 29, tool_id: 2 },
  { insect_id: 30, tool_id: 1 }, # オオウラギンスジヒョウモン（メス）
  { insect_id: 30, tool_id: 2 },
  { insect_id: 31, tool_id: 1 }, # オオクワガタ（オス）
  { insect_id: 31, tool_id: 2 },
  { insect_id: 31, tool_id: 3 },
  { insect_id: 31, tool_id: 4 },
  { insect_id: 31, tool_id: 7 },
  { insect_id: 32, tool_id: 1 }, # オオクワガタ（メス）
  { insect_id: 32, tool_id: 2 },
  { insect_id: 32, tool_id: 3 },
  { insect_id: 32, tool_id: 4 },
  { insect_id: 32, tool_id: 7 },
  { insect_id: 33, tool_id: 1 }, # オオゴマダラ（オス）
  { insect_id: 33, tool_id: 2 },
  { insect_id: 34, tool_id: 1 }, # オオゴマダラ（メス）
  { insect_id: 34, tool_id: 2 },
  { insect_id: 35, tool_id: 1 }, # オオスズメバチ（オス）
  { insect_id: 35, tool_id: 2 },
  { insect_id: 35, tool_id: 3 },
  { insect_id: 35, tool_id: 4 },
  { insect_id: 35, tool_id: 6 },
  { insect_id: 36, tool_id: 1 }, # オオスズメバチ（メス）
  { insect_id: 36, tool_id: 2 },
  { insect_id: 36, tool_id: 3 },
  { insect_id: 36, tool_id: 4 },
  { insect_id: 36, tool_id: 6 },
  { insect_id: 37, tool_id: 1 }, # オオゾウムシ（オス）
  { insect_id: 37, tool_id: 2 },
  { insect_id: 38, tool_id: 1 }, # オオゾウムシ（メス）
  { insect_id: 38, tool_id: 2 },
  { insect_id: 39, tool_id: 1 }, # オオムラサキ（オス）
  { insect_id: 39, tool_id: 2 },
  { insect_id: 40, tool_id: 1 }, # オオムラサキ（メス）
  { insect_id: 40, tool_id: 2 },
  { insect_id: 41, tool_id: 1 }, # オトシブミ（オス）
  { insect_id: 41, tool_id: 2 },
  { insect_id: 42, tool_id: 1 }, # オトシブミ（メス）
  { insect_id: 42, tool_id: 2 },
  { insect_id: 43, tool_id: 1 }, # オニヤンマ（オス）
  { insect_id: 43, tool_id: 2 },
  { insect_id: 44, tool_id: 1 }, # オニヤンマ（メス）
  { insect_id: 44, tool_id: 2 },
  { insect_id: 45, tool_id: 1 }, # オンブバッタ（オス）
  { insect_id: 45, tool_id: 2 },
  { insect_id: 46, tool_id: 1 }, # オンブバッタ（メス）
  { insect_id: 46, tool_id: 2 },
  { insect_id: 47, tool_id: 1 }, # カナブン（オス）
  { insect_id: 47, tool_id: 2 },
  { insect_id: 47, tool_id: 3 },
  { insect_id: 47, tool_id: 4 },
  { insect_id: 48, tool_id: 1 }, # カナブン（メス）
  { insect_id: 48, tool_id: 2 },
  { insect_id: 48, tool_id: 3 },
  { insect_id: 48, tool_id: 4 },
  { insect_id: 49, tool_id: 1 }, # カブトムシ（オス）
  { insect_id: 49, tool_id: 2 },
  { insect_id: 49, tool_id: 3 },
  { insect_id: 49, tool_id: 7 },
  { insect_id: 50, tool_id: 1 }, # カブトムシ（メス）
  { insect_id: 50, tool_id: 2 },
  { insect_id: 50, tool_id: 3 },
  { insect_id: 50, tool_id: 7 },
  { insect_id: 51, tool_id: 1 }, # カラスアゲハ（オス）
  { insect_id: 51, tool_id: 2 },
  { insect_id: 52, tool_id: 1 }, # カラスアゲハ（メス）
  { insect_id: 52, tool_id: 2 },
  { insect_id: 53, tool_id: 1 }, # カンタン（オス）
  { insect_id: 53, tool_id: 2 },
  { insect_id: 54, tool_id: 1 }, # カンタン（メス）
  { insect_id: 54, tool_id: 2 },
  { insect_id: 55, tool_id: 1 }, # キリギリス（オス）
  { insect_id: 55, tool_id: 2 },
  { insect_id: 56, tool_id: 1 }, # キリギリス（メス）
  { insect_id: 56, tool_id: 2 },
  { insect_id: 57, tool_id: 1 }, # ギンヤンマ（オス）
  { insect_id: 57, tool_id: 2 },
  { insect_id: 58, tool_id: 1 }, # ギンヤンマ（メス）
  { insect_id: 58, tool_id: 2 },
  { insect_id: 59, tool_id: 1 }, # クマゼミ（オス）
  { insect_id: 59, tool_id: 2 },
  { insect_id: 60, tool_id: 1 }, # クマゼミ（メス）
  { insect_id: 60, tool_id: 2 },
  { insect_id: 61, tool_id: 1 }, # クマバチ（オス）
  { insect_id: 61, tool_id: 2 },
  { insect_id: 61, tool_id: 4 },
  { insect_id: 61, tool_id: 6 },
  { insect_id: 62, tool_id: 1 }, # クマバチ（メス）
  { insect_id: 62, tool_id: 2 },
  { insect_id: 62, tool_id: 4 },
  { insect_id: 62, tool_id: 6 },
  { insect_id: 63, tool_id: 1 }, # クロアゲハ（オス）
  { insect_id: 63, tool_id: 2 },
  { insect_id: 64, tool_id: 1 }, # クロアゲハ（メス）
  { insect_id: 64, tool_id: 2 },
  { insect_id: 65, tool_id: 1 }, # ゲンジボタル（オス）
  { insect_id: 65, tool_id: 2 },
  { insect_id: 66, tool_id: 1 }, # ゲンジボタル（メス）
  { insect_id: 66, tool_id: 2 },
  { insect_id: 67, tool_id: 1 }, # コクワガタ（オス）
  { insect_id: 67, tool_id: 2 },
  { insect_id: 67, tool_id: 3 },
  { insect_id: 67, tool_id: 4 },
  { insect_id: 67, tool_id: 7 },
  { insect_id: 68, tool_id: 1 }, # コクワガタ（メス）
  { insect_id: 68, tool_id: 2 },
  { insect_id: 68, tool_id: 3 },
  { insect_id: 68, tool_id: 4 },
  { insect_id: 68, tool_id: 7 },
  { insect_id: 69, tool_id: 1 }, # ゴマダラカミキリ（オス）
  { insect_id: 69, tool_id: 2 },
  { insect_id: 70, tool_id: 1 }, # ゴマダラカミキリ（メス）
  { insect_id: 70, tool_id: 2 },
  { insect_id: 71, tool_id: 1 }, # シオカラトンボ（オス）
  { insect_id: 71, tool_id: 2 },
  { insect_id: 72, tool_id: 1 }, # シオカラトンボ（メス）
  { insect_id: 72, tool_id: 2 },
  { insect_id: 73, tool_id: 1 }, # ショウリョウバッタ（オス）
  { insect_id: 73, tool_id: 2 },
  { insect_id: 74, tool_id: 1 }, # ショウリョウバッタ（メス）
  { insect_id: 74, tool_id: 2 },
  { insect_id: 75, tool_id: 1 }, # トノサマバッタ（オス）
  { insect_id: 75, tool_id: 2 },
  { insect_id: 76, tool_id: 1 }, # トノサマバッタ（メス）
  { insect_id: 76, tool_id: 2 },
  { insect_id: 77, tool_id: 1 }, # ナミテントウ（オス）
  { insect_id: 77, tool_id: 2 },
  { insect_id: 78, tool_id: 1 }, # ナミテントウ（メス）
  { insect_id: 78, tool_id: 2 },
  { insect_id: 79, tool_id: 1 }, # ノコギリクワガタ（オス）
  { insect_id: 79, tool_id: 2 },
  { insect_id: 79, tool_id: 3 },
  { insect_id: 79, tool_id: 4 },
  { insect_id: 79, tool_id: 7 },
  { insect_id: 80, tool_id: 1 }, # ノコギリクワガタ（メス）
  { insect_id: 80, tool_id: 2 },
  { insect_id: 80, tool_id: 3 },
  { insect_id: 80, tool_id: 4 },  
  { insect_id: 80, tool_id: 7 },  
  { insect_id: 81, tool_id: 1 }, # ハンミョウ（オス）
  { insect_id: 81, tool_id: 2 },
  { insect_id: 81, tool_id: 6 },
  { insect_id: 82, tool_id: 1 }, # ハンミョウ（メス）
  { insect_id: 82, tool_id: 2 },
  { insect_id: 82, tool_id: 6 },
  { insect_id: 83, tool_id: 1 }, # マイマイカブリ（オス）
  { insect_id: 83, tool_id: 2 },
  { insect_id: 84, tool_id: 1 }, # マイマイカブリ（メス）
  { insect_id: 84, tool_id: 2 },
  { insect_id: 85, tool_id: 1 }, # ミヤマクワガタ（オス）
  { insect_id: 85, tool_id: 2 },
  { insect_id: 85, tool_id: 3 },
  { insect_id: 85, tool_id: 4 },
  { insect_id: 85, tool_id: 7 },
  { insect_id: 86, tool_id: 1 }, # ミヤマクワガタ（メス）
  { insect_id: 86, tool_id: 2 },
  { insect_id: 86, tool_id: 3 },
  { insect_id: 86, tool_id: 4 },
  { insect_id: 86, tool_id: 7 },
  { insect_id: 87, tool_id: 1 }, # ミンミンゼミ（オス）
  { insect_id: 87, tool_id: 2 },
  { insect_id: 88, tool_id: 1 }, # ミンミンゼミ（メス）
  { insect_id: 88, tool_id: 2 },
  { insect_id: 89, tool_id: 1 }, # ヤマトシジミ（オス）
  { insect_id: 89, tool_id: 2 },
  { insect_id: 90, tool_id: 1 }, # ヤマトシジミ（メス）
  { insect_id: 90, tool_id: 2 },
  { insect_id: 91, tool_id: 1 }, # リュウキュウアサギマダラ（オス）
  { insect_id: 91, tool_id: 2 },
  { insect_id: 92, tool_id: 1 }, # リュウキュウアサギマダラ（メス）
  { insect_id: 92, tool_id: 2 },
  { insect_id: 93, tool_id: 1 }, # ルリタテハ（オス）
  { insect_id: 93, tool_id: 2 },
  { insect_id: 94, tool_id: 1 }, # ルリタテハ（メス）
  { insect_id: 94, tool_id: 2 }
]

insect_tools.each do |insect_tool|
  InsectTool.create!(insect_tool)
end

puts 'InsectTools data created!'
