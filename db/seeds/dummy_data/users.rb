# frozen_string_literal: true

puts 'Start inserting Users data...'

5.times do |n|
  User.create!(
    nickname: "test#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: '111111'
  )
end

puts 'Users data created!'
