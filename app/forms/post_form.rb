# frozen_string_literal: true

class PostForm
  include ActiveModel::Model

  attr_accessor :collected_insect_images, :current_user, :error_message

  def save
    post = Post.new(user: current_user)
    ActiveRecord::Base.transaction do
      if post.save!
        collected_insect_images.each do |img|
          # CollectedInsectインスタンス生成
          collected_insect = CollectedInsect.new(
            user: current_user,
            post:
          )
          collected_insect.save!

          # CollectedInsectImageインスタンス生成し、collected_insectに紐付け
          collected_insect_image = CollectedInsectImage.new(
            image: img,
            collected_insect:
          )
          collected_insect_image.save!

          # exifデータから取得したcity_idとtaken_date_timeの登録
          prefecture = Prefecture.find_by(name: collected_insect_image.image.prefecture_name)
          city = City.find_by(name: collected_insect_image.image.city_name, prefecture:)
          taken_date_time = collected_insect_image.image.taken_date_time&.strftime('%Y-%m-%d %H:%M:%S.%N')

          # CollectedInsectインスタンスを更新
          collected_insect.update!(
            taken_date_time:,
            city_id: city&.id
          )
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Validation error in PostForm: #{e.record.errors.full_messages.join(', ')}"
    self.error_message = e.record.errors.full_messages.join(', ')
    false
  rescue StandardError => e
    Rails.logger.error "Unexpected error of type #{e.class} in PostForm: #{e.message}"
    self.error_message = e.message
    false
  end
end
