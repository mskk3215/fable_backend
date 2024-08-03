# frozen_string_literal: true

class SightingNotification < ApplicationRecord
  belongs_to :user
  belongs_to :insect
end
