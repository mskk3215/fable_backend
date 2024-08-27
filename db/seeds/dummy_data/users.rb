# frozen_string_literal: true

puts 'Start inserting Users data...'

names = %w[Ares Blaze Cyrus Drake Elara Faylinn Galen Helix Iris Jaxon Kai Lyra
           Mars Nyx Orion Pax Quinn Rhea Sirius Thalia]

20.times do |n|
  User.create!(
    nickname: names[n],
    email: "#{names[n].downcase}@example.com",
    password: '111111',
    avatar: File.open(Rails.root.join("db/seeds/dummy_data/users/avatar#{n + 1}.png").to_s)
  )
end

puts 'Users data created!'
