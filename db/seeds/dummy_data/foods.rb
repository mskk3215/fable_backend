# frozen_string_literal: true

puts 'Start inserting Foods data'

foods = [
  { name: '果実' },
  { name: '果汁' },
  { name: '花蜜' },
  { name: '花粉' },
  { name: '葉' },
  { name: '茎' },
  { name: '根' },
  { name: '種子' },
  { name: '花' },
  { name: '樹液' },
  { name: '樹皮' },
  { name: '水中の小動物' },
  { name: '小型の飛翔昆虫'},
  { name: '小型の昆虫' },
  { name: 'アブラムシ' },
  { name: 'カタツムリ' },
  { name: '水' },
]

foods.each do |food|
  Food.create!(food)
end

puts 'foods data created!'
