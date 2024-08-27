# frozen_string_literal: true

puts 'Start inserting Likes data...'

# 全てのユーザーと画像を取得
users = User.all
collected_insects = CollectedInsect.all

collected_insects.each do |image|
  likers = users.sample(rand(users.size))

  likers.each do |user|
    Like.create!(user_id: user.id, collected_insect_id: image.id)
  end

  # likes_countを更新
  image.update!(likes_count: image.likes.size)
end

puts 'Likes data created!'
