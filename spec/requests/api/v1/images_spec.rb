# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Images' do
    # データベースのセットアップ
  let!(:insect) { create(:insect, name: 'カブトムシ', sex: 'オス') }
  let!(:prefecture) { create(:prefecture, name: '東京都') }
  let!(:city) { create(:city, name: '渋谷区', prefecture:) }
  let!(:park) { create(:park, name: '代々木公園', city:) }

  let(:user) { create(:user) }
  let!(:new_images) { create_list(:image, 5, user:) }

  before do
    login(user)
  end

  describe 'GET /api/v1/images' do
    it 'イメージのリストを返す' do
      get api_v1_images_path, params: { page: 1, pageSize: 5, sortOption: 0 }

      expect(response).to have_http_status(:ok)
      expect(json['images'].size).to eq(5)
    end
  end

  describe 'PUT /api/v1/images/bulk_update' do
    context '有効なパラメータの場合' do
      let(:image_params) do
        {
          name: 'カブトムシ',
          sex: 'オス',
          prefecture_name: '東京都',
          city_name: '渋谷区',
          park_name: '代々木公園',
          taken_at: '2023-03-14'
        }
      end

      it 'イメージの一括更新を行う' do
        put api_v1_images_bulk_update_path, params: { id: new_images.map(&:id).join(','), image: image_params }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE /api/v1/images/:id' do
    it '指定されたイメージを削除する' do
      expect {
        delete api_v1_image_path(new_images.first.id)
      }.to change(Image, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
