# frozen_string_literal: true

class PostForm
  include ActiveModel::Model

  attr_accessor :images, :current_user

  def save
    post = Post.new(user: current_user)
    ActiveRecord::Base.transaction do
      if post.save!
        # prefecture, cityの事前呼び出し
        prefecture_names = images.map { |img| Image.new(image: img).image.prefecture_name }.uniq
        prefectures = Prefecture.where(name: prefecture_names).index_by(&:name)
        city_names = images.map { |img| Image.new(image: img).image.city_name }.uniq
        cities = City.where(name: city_names).group_by(&:name)

        images.each do |img|
          # imageインスタンスの生成
          image = Image.new(image: img, user: current_user, post:)

          # exifデータから取得したcity_idとtaken_atの登録
          prefecture = prefectures[image.image.prefecture_name]
          city = cities[image.image.city_name]&.find { |c| c.prefecture_id == prefecture&.id }

          date_time = image.image.taken_at&.strftime('%Y-%m-%d %H:%M:%S.%N')
          image.assign_attributes(
            taken_at: date_time,
            city_id: city&.id
          )

          # imageの保存
          image.save!
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  rescue StandardError => e
    Rails.logger.error "Unexpected error of type #{e.class} in PostForm: #{e.message}"
    false
  end
end
