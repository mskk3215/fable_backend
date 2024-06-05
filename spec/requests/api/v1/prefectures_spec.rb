# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Prefectures' do
  describe 'GET /api/v1/prefectures' do
    before do
      prefecture = create(:prefecture, name: '東京都')
      create(:city, name: '新宿', prefecture:)
      create(:city, name: '渋谷', prefecture:)
    end

    it '都道府県とその市町村のリストを返すこと' do
      get api_v1_prefectures_path
      expect(response).to have_http_status(:ok)
      expect(json).to eq([{ 'name' => '東京都', 'cities' => %w[新宿 渋谷] }])
    end
  end
end
