# frozen_string_literal: true

puts 'Start inserting Tools data'

tools = [
  { name: '虫取り網' },
  { name: '虫かご' },
  { name: 'トラップ' },
  { name: 'ピンセット' },
  { name: 'ルーペ' },
  { name: '手袋' },
  { name: 'ライト' },
]

tools.each do |tool|
  Tool.create!(tool)
end

puts 'tools data created!'
