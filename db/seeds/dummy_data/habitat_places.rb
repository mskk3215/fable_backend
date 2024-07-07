# frozen_string_literal: true

puts 'Start inserting Habitat_places data'

habitat_places = [
  { name: '草むら' },
  { name: '水辺' },
  { name: '樹上' },
  { name: '砂地' },  
]

habitat_places.each do |habitat_place|
  HabitatPlace.create!(habitat_place)
end

puts 'Habitat_places data created!'
