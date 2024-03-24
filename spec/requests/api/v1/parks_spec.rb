# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Parks' do
  let!(:prefecture) { create(:prefecture, name: '東京都') }
  let!(:city) { create(:city, name: '新宿区', prefecture:) }
  let!(:park) { create(:park, name: '新宿御苑', city:) }
  let!(:insect) { create(:insect, name: 'カブトムシ') }
  let!(:image) { create(:image, insect:, park:) }

  describe 'GET /api/v1/parks' do
    context '検索ワードがない場合' do
      it '全ての公園のリストを取得する' do
        get api_v1_parks_path
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(1)
        expect(json.first['name']).to eq('新宿御苑')
      end
    end

    context '検索ワードにマッチする昆虫がいる公園を検索する場合' do
      it 'マッチする公園のリストを取得する' do
        get api_v1_parks_path, params: { search_word: 'カブトムシ' }
        expect(response).to have_http_status(:ok)
        expect(json.length).to eq(1)
        expect(json.first['name']).to eq('新宿御苑')
      end
    end

    context '検索ワードにマッチしない昆虫を検索する場合' do
      it '空のリストを返す' do
        get api_v1_parks_path, params: { search_word: 'クワガタ' }
        expect(response).to have_http_status(:ok)
        expect(json).to be_empty
      end
    end
  end
end
