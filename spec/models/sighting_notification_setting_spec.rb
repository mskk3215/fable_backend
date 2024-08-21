# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SightingNotificationSetting do
  let(:insect) { create(:insect) }
  let(:user) { create(:user) }
  let(:sightingnotificationsetting) { SightingNotificationSetting.new(insect:, user:) }

  describe 'バリデーションの確認' do
    it 'insectとuserがある場合は有効である' do
      insect = create(:insect)
      user = create(:user)
      sightingnotificationsetting = SightingNotificationSetting.new(insect:, user:)
      expect(sightingnotificationsetting).to be_valid
    end

    it 'insectがない場合は無効である' do
      user = create(:user)
      sightingnotificationsetting = SightingNotificationSetting.new(insect: nil, user:)
      expect(sightingnotificationsetting).not_to be_valid
      expect(sightingnotificationsetting.errors[:insect]).to include('must exist')
    end

    it 'userがない場合は無効である' do
      insect = create(:insect)
      sightingnotificationsetting = SightingNotificationSetting.new(insect:, user: nil)
      expect(sightingnotificationsetting).not_to be_valid
      expect(sightingnotificationsetting.errors[:user]).to include('must exist')
    end
  end

  describe 'アソシエーションの確認' do
    it 'insectに属していること' do
      expect(SightingNotificationSetting.reflect_on_association(:insect).macro).to eq(:belongs_to)
    end

    it 'userに属していること' do
      expect(SightingNotificationSetting.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end
