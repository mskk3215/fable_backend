puts 'Start inserting Relationships data'

users = User.all

users.each do |user|
  # 自分自身を除いたユーザーの配列を作成
  other_users = users.reject { |u| u.id == user.id }
  
  # 15人以上をランダムに選択
  followed_users = other_users.sample(rand(10..other_users.size))

  followed_users.each do |followed_user|
    Relationship.create!(follower_id: user.id, followed_id: followed_user.id)
  end
end

puts 'Relationships data created!'
