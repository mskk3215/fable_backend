# frozen_string_literal: true

require 'unicode'

puts 'Start inserting Posts and Images data'

image_filenames = Dir[Rails.root.join('db/seeds/dummy_data/images/*.png')]

# parkのseedsデータをイテレーション可能な形にする
parks = Park.all.to_a

user_id = 1

def create_collected_insect_and_image(insect_name, sex, park_id, city_id, user_id, post_id, taken_date_time, image_path)
  # Unicode正規化
  normalized_insect_name = Unicode.nfkc(insect_name) 

  # 必須項目の値を指定してfind_or_create_by!を呼び出す
  insect = Insect.find_by!(name: normalized_insect_name)

  park = Park.find(park_id)
  city = City.find(city_id)
  user = User.find(user_id)
  post = Post.find(post_id)

  ActiveRecord::Base.transaction do
    begin
      collected_insect = CollectedInsect.new(
        insect_id: insect.id,
        sex: sex,
        park_id: park.id,
        city_id: city.id,
        user_id: user.id,
        post_id: post.id,
        taken_date_time: taken_date_time
      )

      if collected_insect.valid?
        collected_insect.save!

        collected_insect_image = CollectedInsectImage.new(image: File.open(image_path))
        collected_insect_image.collected_insect = collected_insect
        collected_insect_image.save!

      else
        puts "採集済み昆虫の作成に失敗しました: #{collected_insect.errors.full_messages}"
        raise ActiveRecord::Rollback
      end
    rescue => e
      puts "採集済み昆虫の作成中にエラーが発生しました: #{e.message}"
      raise ActiveRecord::Rollback
    end
  end
end

def extract_insect_name_and_sex(filename)
  # ファイル名からinsectの名前と性別を抽出するロジック
  parts = File.basename(filename, '.png').split('_')
  name = parts[0] # 名前部分

  # 名前の最後に数字がある場合、その数字を削除
  name.gsub!(/\d+$/, '')

  sex = parts[1]
  [name, sex]
end

# user_id=1の場合は、画像をランダムに50枚読み込んで10枚ずつpostします。
if user_id == 1
  # 画像をランダムにシャッフルして、最初の50枚を選択
  random_images = image_filenames.shuffle.take(50)

  random_images.each_slice(10) do |images_slice|
    post = Post.create!(user_id: user_id)

    images_slice.each do |image_path|

      insect_name, sex = extract_insect_name_and_sex(image_path)

      park = parks.sample
      park_id = park.id
      city_id = park.city_id

      # ランダムな日時を生成
      start_date = Time.zone.local(2023, 7, 1)
      end_date = Time.zone.local(2023, 8, 31)
      random_time = Time.zone.at(((end_date.to_f - start_date.to_f) * rand) + start_date.to_f)

      # CollectedInsectとCollectedInsectImageを作成
      create_collected_insect_and_image(insect_name, sex, park_id, city_id, user_id, post.id, random_time, image_path)
    end
  end
end

# user_id=2からuser_id=20まで、画像をランダムに10枚読み込む
(2..20).each do |user_id|
  random_images = image_filenames.shuffle.take(10)

  post = Post.create!(user_id: user_id)

  random_images.each do |image_path|
    insect_name, sex = extract_insect_name_and_sex(image_path)

    park = parks.sample
    park_id = park.id
    city_id = park.city_id

    start_date = Time.zone.local(2023, 7, 1)
    end_date = Time.zone.local(2023, 8, 31)
    random_time = Time.zone.at(((end_date.to_f - start_date.to_f) * rand) + start_date.to_f)

      create_collected_insect_and_image(insect_name, sex, park_id, city_id, user_id, post.id, random_time, image_path)
  end
end

puts 'Posts and Images data created!'
