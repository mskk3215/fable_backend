# frozen_string_literal: true

require 'unicode'

puts 'Start inserting Post_images data'

image_filenames = Dir[Rails.root.join('db/seeds/dummy_data/images/*.png')]

# parkのseedsデータをイテレーション可能な形にする
parks = Park.all.to_a
park_index = 0

user_id = 1
# user_id=1の場合は、画像をランダムに50枚読み込んで10枚ずつpostします。
if user_id == 1
  # 画像をランダムにシャッフルして、最初の50枚を選択
  random_images = image_filenames.shuffle.take(50)

  # 10枚ずつに分けて投稿を作成
  random_images.each_slice(10) do |images_slice|
    post = Post.create!(user_id: user_id)

    images_slice.each do |image_path|
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
      # collected_insect_imagesテーブルのデータ作成
      image = CollectedInsectImage.new(
        image: File.open(image_path),
        created_at: '2023-09-01 13:55:13.469244',
        taken_at: random_time,
        insect_id: insect_id,
        park_id: park_id,
        city_id: city_id,
        user_id: user_id,
        post_id: post.id
      )
      image.save!
    end
  end
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
    # collected_insect_imagesテーブルのデータ作成
    image = CollectedInsectImage.new(
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
