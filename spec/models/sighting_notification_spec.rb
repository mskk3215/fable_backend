# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SightingNotification do
  let(:user) { create(:user) }
  let(:collected_insect) { create(:collected_insect) }
  let(:sighting_notification) { SightingNotification.new(user:, collected_insect:) }

  describe 'バリデーションの確認' do
    it 'is_read が true または false である場合は有効である' do
      sighting_notification.is_read = true
      expect(sighting_notification).to be_valid

      sighting_notification.is_read = false
      expect(sighting_notification).to be_valid
    end

    it 'is_read が nil である場合は無効である' do
      sighting_notification.is_read = nil
      expect(sighting_notification).not_to be_valid
      expect(sighting_notification.errors[:is_read]).to include('is not included in the list')
    end
  end

  describe 'アソシエーションの確認' do
    it 'user に属していること' do
      expect(SightingNotification.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'collected_insect に属していること' do
      expect(SightingNotification.reflect_on_association(:collected_insect).macro).to eq(:belongs_to)
    end
  end
end
