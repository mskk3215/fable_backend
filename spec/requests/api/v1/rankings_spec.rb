# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Rankings' do
  describe 'GET /api/v1/rankings' do
    let!(:prefecture) { create(:prefecture, name: '東京都') }
    let!(:city) { create(:city, name: '渋谷区', prefecture:) }
    let!(:user1) { create(:user, nickname: 'ユーザー1') }
    let!(:user2) { create(:user, nickname: 'ユーザー2') }
    let!(:biological_family) { create(:biological_family) }
    let!(:insect1) { create(:insect, biological_family:) }
    let!(:insect2) { create(:insect, biological_family:) }
    let!(:image1) { create(:image, user: user1, city:, insect: insect1) }
    let!(:image2) { create(:image, user: user1, city:, insect: insect2) }
    let!(:image3) { create(:image, user: user2, city:, insect: insect1) }

    before do
      login(user1)
      get api_v1_rankings_path, params: { prefecture_name: prefecture.name, city_name: city.name }
    end

    it 'ランキングデータを正しく返す' do
      expect(response).to have_http_status(:ok)
      rankings = json['rankings']
      expect(rankings.size).to eq(2)
      expect(rankings[0]['user_name']).to eq(user1.nickname)
      expect(rankings[0]['collection_rate']).to be > rankings[1]['collection_rate']
      expect(rankings[1]['user_name']).to eq(user2.nickname)
    end
  end
end
