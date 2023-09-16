# frozen_string_literal: true

class Post < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :user
  has_many :images, dependent: :destroy

  def self.fetch_all_with_includes
    all.includes(images: %i[insect park city user
                            likes]).order(created_at: :desc)
  end

  def self.for_followed_users(user)
    where(user_id: user.following.pluck(:id))
  end

  def self.from_the_last_week
    where('created_at > ?', 1.week.ago)
  end

  def self.sort_by_recent_likes
    all.to_a.sort_by { |post| post.images.sum(&:likes_count) }.reverse
  end
end
