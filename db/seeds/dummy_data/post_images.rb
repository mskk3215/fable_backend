# frozen_string_literal: true

require 'unicode'

puts 'Start inserting Posts and Images data'

image_filenames = Dir[Rails.root.join('db/seeds/dummy_data/images/*.png')]

# parkのseedsデータをイテレーション可能な形にする
parks = Park.all.to_a

def extract_insect_name_and_sex(filename)
  # ファイル名からinsectの名前と性別を抽出するロジック
  parts = File.basename(filename, '.png').unicode_normalize(:nfc).split('_')
  name = parts[0].gsub(/\d+$/, '')
  sex = parts[1]

  [Unicode.nfkc(name), sex]
end

  # 昆虫毎の日時設定関数。
  insect_settings = [
  { name: 'アオスジアゲハ', start_date: "2023-04-21", end_date: "2023-10-30" , start_time: "09:00", end_time: "16:00"},
  { name: 'アオタテハモドキ', start_date: "2023-05-11", end_date: "2023-10-20" , start_time: "10:00", end_time: "17:00" },
  { name: 'アオハダトンボ', start_date: "2023-06-11", end_date: "2023-08-20" , start_time: "09:00", end_time: "15:00" },
  { name: 'アオマツムシ', start_date: "2023-08-11", end_date: "2023-10-20" , start_time: "18:00", end_time: "22:00"},
  { name: 'アカシジミ', start_date: "2023-06-01", end_date: "2023-07-20" , start_time: "07:00", end_time: "12:00" },
  { name: 'アカタテハ', start_date: "2023-04-01", end_date: "2023-11-10" , start_time: "10:00", end_time: "16:00"},
  { name: 'アカハナカミキリ', start_date: "2023-06-01", end_date: "2023-09-30" , start_time: "08:00", end_time: "15:00" },
  { name: 'アキアカネ', start_date: "2023-09-11", end_date: "2023-11-10" , start_time: "09:00", end_time: "17:00"},
  { name: 'アサギマダラ', start_date: "2023-05-01", end_date: "2023-10-10" , start_time: "10:00", end_time: "16:00" },
  { name: 'アブラゼミ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "07:00", end_time: "17:00" },
  { name: 'アメンボ', start_date: "2023-05-11", end_date: "2023-10-30", start_time: "08:00", end_time: "18:00" },
  { name: 'イシガケチョウ', start_date: "2023-04-21", end_date: "2023-10-10", start_time: "09:00", end_time: "15:00" },
  { name: 'イチモンジセセリ', start_date: "2023-06-01", end_date: "2023-11-10", start_time: "08:00", end_time: "14:00" },
  { name: 'エンマコオロギ', start_date: "2023-08-11", end_date: "2023-11-10", start_time: "18:00", end_time: "22:00" },
  { name: 'オオウラギンスジヒョウモン', start_date: "2023-07-01", end_date: "2023-09-20", start_time: "09:00", end_time: "14:00" },
  { name: 'オオクワガタ', start_date: "2023-06-21", end_date: "2023-08-10", start_time: "20:00", end_time: "23:00" },
  { name: 'オオゴマダラ', start_date: "2023-05-01", end_date: "2023-10-20", start_time: "09:00", end_time: "16:00" },
  { name: 'オオスズメバチ', start_date: "2023-05-01", end_date: "2023-10-30", start_time: "09:00", end_time: "15:00" },
  { name: 'オオゾウムシ', start_date: "2023-05-01", end_date: "2023-09-30", start_time: "09:00", end_time: "17:00" },
  { name: 'オオムラサキ', start_date: "2023-06-01", end_date: "2023-08-20", start_time: "10:00", end_time: "14:00" },
  { name: 'オトシブミ', start_date: "2023-05-11", end_date: "2023-07-10", start_time: "08:00", end_time: "16:00" },
  { name: 'オニヤンマ', start_date: "2023-07-21", end_date: "2023-09-20", start_time: "10:00", end_time: "15:00" },
  { name: 'オンブバッタ', start_date: "2023-08-11", end_date: "2023-10-30", start_time: "08:00", end_time: "17:00" },
  { name: 'カナブン', start_date: "2023-06-01", end_date: "2023-09-20", start_time: "07:00", end_time: "18:00" },
  { name: 'カブトムシ', start_date: "2023-06-21", end_date: "2023-08-10", start_time: "20:00", end_time: "23:00" },
  { name: 'カラスアゲハ', start_date: "2023-05-11", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
  { name: 'カンタン', start_date: "2023-08-11", end_date: "2023-10-10", start_time: "18:00", end_time: "22:00" },
  { name: 'キリギリス', start_date: "2023-06-11", end_date: "2023-09-30", start_time: "17:00", end_time: "21:00" },
  { name: 'ギンヤンマ', start_date: "2023-05-11", end_date: "2023-10-20", start_time: "08:00", end_time: "17:00" },
  { name: 'クマゼミ', start_date: "2023-07-11", end_date: "2023-08-30", start_time: "07:00", end_time: "12:00" },
  { name: 'クマバチ', start_date: "2023-03-11", end_date: "2023-10-20", start_time: "09:00", end_time: "17:00" },
  { name: 'クロアゲハ', start_date: "2023-04-21", end_date: "2023-10-30", start_time: "10:00", end_time: "15:00" },
  { name: 'ゲンジボタル', start_date: "2023-05-11", end_date: "2023-07-10", start_time: "19:00", end_time: "22:00" },
  { name: 'コクワガタ', start_date: "2023-06-11", end_date: "2023-08-30", start_time: "20:00", end_time: "23:00" },
  { name: 'ゴマダラカミキリ', start_date: "2023-06-01", end_date: "2023-08-10", start_time: "09:00", end_time: "14:00" },
  { name: 'シオカラトンボ', start_date: "2023-06-01", end_date: "2023-09-20", start_time: "08:00", end_time: "15:00" },
  { name: 'ショウリョウバッタ', start_date: "2023-07-21", end_date: "2023-10-20", start_time: "10:00", end_time: "17:00" },
  { name: 'トノサマバッタ', start_date: "2023-07-21", end_date: "2023-09-20", start_time: "09:00", end_time: "15:00" },
  { name: 'ナミテントウ', start_date: "2023-03-11", end_date: "2023-10-30", start_time: "08:00", end_time: "18:00" },
  { name: 'ノコギリクワガタ', start_date: "2023-06-01", end_date: "2023-08-30", start_time: "20:00", end_time: "23:00" },
  { name: 'ハンミョウ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
  { name: 'マイマイカブリ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
  { name: 'ミヤマクワガタ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
  { name: 'ミンミンゼミ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
  { name: 'ヤマトシジミ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
  { name: 'リュウキュウアサギマダラ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
  { name: 'ルリタテハ', start_date: "2023-07-21", end_date: "2023-09-10", start_time: "09:00", end_time: "16:00" },
].index_by { |insect| insect[:name] }


# 各昆虫の画像を昆虫名でグループ化
grouped_images = image_filenames.group_by { |filename| extract_insect_name_and_sex(filename).first }

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

        # 通知を作成
        collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)

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

def generate_random_time(date, start_hour, end_hour)
  random_hour = rand(start_hour.to_i..end_hour.to_i)
  random_minute = rand(0..59)
  random_second = rand(0..59)
  Time.zone.local(date.year, date.month, date.day, random_hour, random_minute, random_second)
end

def generate_random_date(start_date, end_date)
  start_date = Time.zone.parse(start_date)
  end_date = Time.zone.parse(end_date)
  Time.zone.at(rand(start_date.to_f..end_date.to_f))
end

# user_id=1からuser_id=20まで、画像をランダムに72枚読み込む
(1..20).each do |user_id|
  random_images = image_filenames.shuffle.take(72)

  random_images.each_slice(8) do |image_slice|
    post = Post.create!(user_id: user_id)

    image_slice.each do |image_path|
    insect_name, sex = extract_insect_name_and_sex(image_path)
    settings = insect_settings[insect_name]

    park = parks.sample
    park_id = park.id
    city_id = park.city_id

    # 日付と時間帯の範囲を昆虫ごとに設定
    random_date = generate_random_date(settings[:start_date], settings[:end_date])
    random_date_time = generate_random_time(random_date, settings[:start_time], settings[:end_time])

      create_collected_insect_and_image(insect_name, sex, park_id, city_id, user_id, post.id, random_date_time, image_path)
  end
end
end

# user_id=2でinsect_id~16,34,40,43の昆虫をcreated_atより1週間以内前の撮影日時でpostする
  user_id = 2
  user = User.find(user_id)
  random_images = image_filenames.select{|filename| filename.include?('クワガタ')}.shuffle.take(15)

  post = Post.create!(user_id: user_id)

  random_images.each do |image_path|
    insect_name, sex = extract_insect_name_and_sex(image_path)

    park = parks.sample
    park_id = park.id
    city_id = park.city_id

    start_date = Time.zone.now - 1.week
    end_date = Time.zone.now
    random_time = Time.zone.at(((end_date.to_f - start_date.to_f) * rand) + start_date.to_f)

      create_collected_insect_and_image(insect_name, sex, park_id, city_id, user_id, post.id, random_time, image_path)
  end

puts 'Posts and Images data created!'
