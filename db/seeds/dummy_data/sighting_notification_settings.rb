puts 'Start inserting SightingNotificationSettings data'

users = User.all

users.each do |user|
  if user.id == 1
    # user.id = 1の場合、特定のinsect_id(クワガタ科)を関連付け
    insect_ids = [16, 40, 34, 43]
    insect_ids.each do |insect_id|
      SightingNotificationSetting.create!(user_id: user.id, insect_id: insect_id)
    end
  else
    # その他のユーザーに対してはランダムに昆虫を関連付け
    insects = Insect.all.sample(rand(3..5))
    insects.each do |insect|
      SightingNotificationSetting.create!(user_id: user.id, insect_id: insect.id)
    end
  end
end

puts 'SightingNotificationSettings data created!'
