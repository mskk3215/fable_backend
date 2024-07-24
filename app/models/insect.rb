# frozen_string_literal: true

class Insect < ApplicationRecord
  validates :name, presence: true
  validates :size, presence: true
  validates :lifespan, presence: true

  has_many :collected_insects, dependent: :destroy
  has_many :insect_foods, dependent: :destroy
  has_many :foods, through: :insect_foods
  has_many :insect_tools, dependent: :destroy
  has_many :tools, through: :insect_tools

  belongs_to :habitat_place, dependent: :destroy
  belongs_to :biological_family, dependent: :destroy

  # 各月の撮影枚数を取得するメソッド
  def taken_amount_per_month
    (1..12).map do |month|
      count = collected_insects.count do |collected_insect|
        collected_insect &&
          collected_insect.taken_date_time.month == month
      end
      {
        month:,
        count:
      }
    end
  end

  # 3時間ごとの撮影枚数を取得するメソッド
  def taken_amount_per_hour
    (0..7).map do |hour|
      start_hour = hour * 3
      end_hour = start_hour + 2
      count = collected_insects.count do |collected_insect|
        collected_insect &&
          (start_hour..end_hour).cover?(collected_insect.taken_date_time.hour)
      end
      {
        time_slot: "#{start_hour}:00 - #{end_hour}:59",
        count:
      }
    end
  end
end
