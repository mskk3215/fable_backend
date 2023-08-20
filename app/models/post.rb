# frozen_string_literal: true

class Post < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :user
  has_many :images, dependent: :destroy
end
