# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users::Statistics' do
  let(:user) { create(:user) }
  let(:prefecture) { create(:prefecture, name: '東京都') }
  let(:city) { create(:city, name: '渋谷', prefecture:) }
  let!(:insect) { create(:insect) }
  let!(:image) { create(:image, user:, city:, insect:) }

  describe 'GET /api/v1/users/:user_id/statistics' do
    context 'ログインしているユーザーが自分の統計情報を要求した場合' do
      before do
        login(user)
      end

      it '統計情報を正しく返すこと' do
        get api_v1_user_statistics_path(user_id: user.id)

        expect(response).to have_http_status(:ok)
        expect(json['statistics']['insect_count']).to eq(1)
        expect(json['statistics']['collected_insect_count']).to eq(1)
        expect(json['statistics']['uncollected_insect_count']).to eq(0)
        expect(json['statistics']['collection_rate']).to eq(100.0)
      end
    end
  end
end
