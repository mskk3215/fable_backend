# frozen_string_literal: true

class SightingNotificationSetting < ApplicationRecord
  belongs_to :user
  belongs_to :insect
end
