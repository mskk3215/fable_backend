# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Rankings' do
  describe 'GET /api/v1/rankings' do
    let!(:prefecture) { create(:prefecture, name: '東京都') }
    let!(:city) { create(:city, name: '渋谷区', prefecture:) }
    let!(:first_user) { create(:user, nickname: 'ユーザー1') }
    let!(:second_user) { create(:user, nickname: 'ユーザー2') }
    let!(:biological_family) { create(:biological_family) }
    let!(:first_insect) { create(:insect, biological_family:) }
    let!(:second_insect) { create(:insect, biological_family:) }
    let!(:first_collected_insect) { create(:collected_insect, user: first_user, city:, insect: first_insect) }
    let!(:second_collected_insect) { create(:collected_insect, user: first_user, city:, insect: second_insect) }
    let!(:third_collected_insect) { create(:collected_insect, user: second_user, city:, insect: first_insect) }

    before do
      login(first_user)
      get api_v1_rankings_path, params: { prefecture_name: prefecture.name, city_name: city.name }
    end

    it 'ランキングデータを正しく返す' do
      expect(response).to have_http_status(:ok)
      rankings = json['rankings']
      expect(rankings.size).to eq(2)
      expect(rankings[0]['user_name']).to eq(first_user.nickname)
      expect(rankings[0]['collection_rate']).to be > rankings[1]['collection_rate']
      expect(rankings[1]['user_name']).to eq(second_user.nickname)
    end
  end
end
