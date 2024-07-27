# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::CollectedInsects' do
  # データベースのセットアップ
  let!(:insect) { create(:insect, name: 'カブトムシ') }
  let!(:prefecture) { create(:prefecture, name: '東京都') }
  let!(:city) { create(:city, name: '渋谷区', prefecture:) }
  let!(:park) { create(:park, name: '代々木公園', city:) }

  let(:user) { create(:user) }
  let!(:collected_insects) { create_list(:collected_insect, 5, user:) }

  before do
    login(user)
  end

  describe 'GET /api/v1/collected_insects' do
    it 'collected_insectのリストを返す' do
      get api_v1_collected_insects_path, params: { page: 1, pageSize: 5, sortOption: 0 }
      expect(response).to have_http_status(:ok)
      expect(json['collected_insects'].size).to eq(5)
    end
  end

  describe 'PUT /api/v1/collected_insects/bulk_update' do
    context '有効なパラメータの場合' do
      let(:collected_insect_params) do
        {
          name: 'カブトムシ',
          sex: 'オス',
          prefecture_name: '東京都',
          city_name: '渋谷区',
          park_name: '代々木公園',
          taken_date_time: '2023-03-14'
        }
      end

      it 'collected_insectの一括更新を行う' do
        put api_v1_collected_insects_bulk_update_path, params: { id: collected_insects.map(&:id).join(','), collected_insect: collected_insect_params }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE /api/v1/collected_insects/:id' do
    it '指定されたcollected_insectを削除する' do
      expect {
        delete api_v1_collected_insect_path(collected_insects.first.id)
      }.to change(CollectedInsect, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
