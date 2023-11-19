# frozen_string_literal: true

require 'unicode'

puts 'Start inserting Post_images data'

image_filenames = Dir[Rails.root.join('db/seeds/dummy_data/images/*.png')]

# parkのseedsデータをイテレーション可能な形にする
parks = Park.all.to_a
park_index = 0

# user_id=1で全ての画像を読み込む
user_id = 1
image_filenames.each do |image_path|
  # insect_idをファイル名から抽出
  insect_id = File.basename(image_path, '.png').split('_').last.to_i
  normalized_path = Unicode.normalize_C(image_path)
  if normalized_path.include?('カブトムシ')
    park = parks[park_index]
    park_index = (park_index + 1) % parks.length
  else
    park = parks.sample
  end
  park_id = park.id
  city_id = park.city_id

  # postsテーブルのデータ作成
  post = Post.create!(user_id:)

  # ランダムな日時を生成
  start_date = Time.zone.local(2023, 7, 1)
  end_date = Time.zone.local(2023, 8, 31)
  random_time = Time.zone.at(((end_date.to_f - start_date.to_f) * rand) + start_date.to_f)

  # imagesテーブルのデータ作成
  image = Image.new(
    image: File.open(image_path),
    created_at: '2023-09-01 13:55:13.469244',
    taken_at: random_time,
    insect_id:,
    park_id:,
    city_id:,
    user_id:,
    post_id: post.id
  )
  image.save!
end

# user_id=2からuser_id=20まで、画像をランダムに10枚読み込む
(2..20).each do |user_id|
  # 画像をランダムにシャッフルして、最初の10枚を選択
  random_images = image_filenames.shuffle.take(10)

  post = Post.create!(user_id:)

  random_images.each do |image_path|
    # insect_idをファイル名から抽出
    insect_id = File.basename(image_path, '.png').split('_').last.to_i

    park = parks.sample
    park_id = park.id
    city_id = park.city_id

    # ランダムな日時を生成
    start_date = Time.zone.local(2023, 7, 1)
    end_date = Time.zone.local(2023, 8, 31)
    random_time = Time.zone.at(((end_date.to_f - start_date.to_f) * rand) + start_date.to_f)

    # imagesテーブルのデータ作成
    image = Image.new(
      image: File.open(image_path),
      created_at: '2023-09-01 13:55:13.469244',
      taken_at: random_time,
      insect_id:,
      park_id:,
      city_id:,
      user_id:,
      post_id: post.id
    )
    image.save!
  end
end

puts 'Post_images data created!'
