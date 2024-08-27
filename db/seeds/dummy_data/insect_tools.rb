# frozen_string_literal: true

puts 'Start inserting InsectTools data'

insect_tools = [
  { insect_id: 1, tool_id: 1 }, # アオスジアゲハ
  { insect_id: 1, tool_id: 2 },
  { insect_id: 2, tool_id: 1 }, # アオタテハモドキ
  { insect_id: 2, tool_id: 2 },
  { insect_id: 3, tool_id: 1 }, # アオハダトンボ
  { insect_id: 3, tool_id: 2 },
  { insect_id: 4, tool_id: 1 }, # アオマツムシ
  { insect_id: 4, tool_id: 2 },
  { insect_id: 5, tool_id: 1 }, # アカシジミ
  { insect_id: 5, tool_id: 2 },
  { insect_id: 6, tool_id: 1 }, # アカタテハ
  { insect_id: 6, tool_id: 2 },
  { insect_id: 7, tool_id: 1 }, # アカハナカミキリ
  { insect_id: 7, tool_id: 2 },
  { insect_id: 7, tool_id: 4 },
  { insect_id: 8, tool_id: 1 }, # アキアカネ
  { insect_id: 8, tool_id: 2 },
  { insect_id: 9, tool_id: 1 }, # アサギマダラ
  { insect_id: 9, tool_id: 2 },
  { insect_id: 10, tool_id: 1 }, # アブラゼミ
  { insect_id: 10, tool_id: 2 },
  { insect_id: 11, tool_id: 1 }, # アメンボ
  { insect_id: 11, tool_id: 2 },
  { insect_id: 12, tool_id: 1 }, # イシガケチョウ
  { insect_id: 12, tool_id: 2 },
  { insect_id: 13, tool_id: 1 }, # イチモンジセセリ
  { insect_id: 13, tool_id: 2 },
  { insect_id: 14, tool_id: 1 }, # エンマコオロギ
  { insect_id: 14, tool_id: 2 },
  { insect_id: 15, tool_id: 1 }, # オオウラギンスジヒョウモン
  { insect_id: 15, tool_id: 2 },
  { insect_id: 16, tool_id: 1 }, # オオクワガタ
  { insect_id: 16, tool_id: 2 },
  { insect_id: 16, tool_id: 3 },
  { insect_id: 16, tool_id: 4 },
  { insect_id: 16, tool_id: 7 },
  { insect_id: 17, tool_id: 1 }, # オオゴマダラ
  { insect_id: 17, tool_id: 2 },
  { insect_id: 18, tool_id: 1 }, # オオスズメバチ
  { insect_id: 18, tool_id: 2 },
  { insect_id: 18, tool_id: 3 },
  { insect_id: 18, tool_id: 4 },
  { insect_id: 18, tool_id: 6 },
  { insect_id: 19, tool_id: 1 }, # オオゾウムシ
  { insect_id: 19, tool_id: 2 },
  { insect_id: 20, tool_id: 1 }, # オオムラサキ
  { insect_id: 20, tool_id: 2 },
  { insect_id: 21, tool_id: 1 }, # オトシブミ
  { insect_id: 21, tool_id: 2 },
  { insect_id: 22, tool_id: 1 }, # オニヤンマ
  { insect_id: 22, tool_id: 2 },
  { insect_id: 23, tool_id: 1 }, # オンブバッタ
  { insect_id: 23, tool_id: 2 },
  { insect_id: 24, tool_id: 1 }, # カナブン
  { insect_id: 24, tool_id: 2 },
  { insect_id: 24, tool_id: 3 },
  { insect_id: 24, tool_id: 4 },
  { insect_id: 25, tool_id: 1 }, # カブトムシ
  { insect_id: 25, tool_id: 2 },
  { insect_id: 25, tool_id: 3 },
  { insect_id: 25, tool_id: 7 },
  { insect_id: 26, tool_id: 1 }, # カラスアゲハ
  { insect_id: 26, tool_id: 2 },
  { insect_id: 27, tool_id: 1 }, # カンタン
  { insect_id: 27, tool_id: 2 },
  { insect_id: 28, tool_id: 1 }, # キリギリス
  { insect_id: 28, tool_id: 2 },
  { insect_id: 29, tool_id: 1 }, # ギンヤンマ
  { insect_id: 29, tool_id: 2 },
  { insect_id: 30, tool_id: 1 }, # クマゼミ
  { insect_id: 30, tool_id: 2 },
  { insect_id: 31, tool_id: 1 }, # クマバチ
  { insect_id: 31, tool_id: 2 },
  { insect_id: 31, tool_id: 4 },
  { insect_id: 31, tool_id: 6 },
  { insect_id: 32, tool_id: 1 }, # クロアゲハ
  { insect_id: 32, tool_id: 2 },
  { insect_id: 33, tool_id: 1 }, # ゲンジボタル
  { insect_id: 33, tool_id: 2 },
  { insect_id: 34, tool_id: 1 }, # コクワガタ
  { insect_id: 34, tool_id: 2 },
  { insect_id: 34, tool_id: 3 },
  { insect_id: 34, tool_id: 4 },
  { insect_id: 34, tool_id: 7 },
  { insect_id: 35, tool_id: 1 }, # ゴマダラカミキリ
  { insect_id: 35, tool_id: 2 },
  { insect_id: 36, tool_id: 1 }, # シオカラトンボ
  { insect_id: 36, tool_id: 2 },
  { insect_id: 37, tool_id: 1 }, # ショウリョウバッタ
  { insect_id: 37, tool_id: 2 },
  { insect_id: 38, tool_id: 1 }, # トノサマバッタ
  { insect_id: 38, tool_id: 2 },
  { insect_id: 39, tool_id: 1 }, # ナミテントウ
  { insect_id: 39, tool_id: 2 },
  { insect_id: 40, tool_id: 1 }, # ノコギリクワガタ
  { insect_id: 40, tool_id: 2 },
  { insect_id: 40, tool_id: 3 },
  { insect_id: 40, tool_id: 4 },
  { insect_id: 40, tool_id: 7 },
  { insect_id: 41, tool_id: 1 }, # ハンミョウ
  { insect_id: 41, tool_id: 2 },
  { insect_id: 41, tool_id: 6 },
  { insect_id: 42, tool_id: 1 }, # マイマイカブリ
  { insect_id: 42, tool_id: 2 },
  { insect_id: 43, tool_id: 1 }, # ミヤマクワガタ
  { insect_id: 43, tool_id: 2 },
  { insect_id: 43, tool_id: 3 },
  { insect_id: 43, tool_id: 4 },
  { insect_id: 43, tool_id: 7 },
  { insect_id: 44, tool_id: 1 }, # ミンミンゼミ
  { insect_id: 44, tool_id: 2 },
  { insect_id: 45, tool_id: 1 }, # ヤマトシジミ
  { insect_id: 45, tool_id: 2 },
  { insect_id: 46, tool_id: 1 }, # リュウキュウアサギマダラ
  { insect_id: 46, tool_id: 2 },
  { insect_id: 47, tool_id: 1 }, # ルリタテハ
  { insect_id: 47, tool_id: 2 }
]

insect_tools.each do |insect_tool|
  InsectTool.create!(insect_tool)
end

puts 'InsectTools data created!'
