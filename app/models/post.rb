# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  
  # 全ての画像にinsect,park,city,user,likesを含めて作成日の降順で取得
  def self.fetch_all_with_includes
    includes(images: %i[insect park city user
                        likes]).order(created_at: :desc)
  end
  # フォローしているユーザーidを取得
  def self.for_followed_users(user)
    where(user_id: user.following.pluck(:id))
  end
  # 1週間以内に作成された投稿を取得
  def self.from_the_last_week
    where('created_at > ?', 1.week.ago)
  end
  # いいねが５以上をいいねの多い順に投稿を取得
  def self.sort_by_likes_with_minimum_five
    all.select { |post| post.images.sum(&:likes_count) >= 5 }
       .sort_by { |post| post.images.sum(&:likes_count) }.reverse
  end
end
