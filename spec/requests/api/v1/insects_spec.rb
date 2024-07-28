# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Insects' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:park) { create(:park) }
  let(:insects) { create_list(:insect, 3, name: %w[カブトムシ ノコギリクワガタ カナブン]) }

  before do
    insects.each do |insect|
      create(:collected_insect, user: other_user, insect:, park:)
    end
  end

  describe 'GET /api/v1/insects' do
    context 'キーワードにマッチする昆虫のリストを取得する場合' do
      let(:query_word) { 'カブトムシ' }

      it 'キーワードにマッチする昆虫のリストを正しく取得できること' do
        get api_v1_insects_path, params: { query_word: }

        expect(response).to have_http_status(:ok)
        expect(json.size).to be >= 1
        expect(json.any? { |insect| insect['insect_name'].include?(query_word) }).to be true
      end
    end

    context '採集済み昆虫のリストを取得する場合' do
      before do
        login(user)
        create(:collected_insect, user:, insect: insects.first, park:, sex: 'オス')
      end

      it '採集済み昆虫のリストを正しく取得できること' do
        get api_v1_insects_path(status: 'collected')

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(1)
        expect(json.first['insect_name']).to eq(insects.first.name)
      end
    end

    context '未採集昆虫のリストを取得する場合' do
      before do
        login(user)
        create(:collected_insect, user:, insect: insects.first)
      end

      it '未採集昆虫のリストを正しく取得できること' do
        get api_v1_insects_path(status: 'uncollected')

        expect(response).to have_http_status(:ok)
        uncollected_insects = json
        expect(uncollected_insects.size).to be >= 1
      end
    end

    context '採集済みと未採集の昆虫を比較する場合' do
      before do
        login(user)
        insects.each do |insect|
          create(:collected_insect, insect:, user:)
        end
      end

      it '採集済みと未採集の昆虫の間に重複がないこと' do
        get api_v1_insects_path(status: 'collected'), params: { user_id: user.id }
        collected_insects_ids = json.pluck('id')

        get api_v1_insects_path(status: 'uncollected'), params: { user_id: user.id }
        uncollected_insects_ids = json.pluck('id')

        expect(collected_insects_ids & uncollected_insects_ids).to be_empty
      end
    end
  end

  describe 'GET /api/v1/insects/:insect_id' do
    before do
      login(user)
    end

    it '昆虫の詳細情報を返す' do
      get api_v1_insect_path(insects.first.id)

      expect(response).to have_http_status(:ok)
      expect(json['insect']['insect_id']).to eq(insects.first.id)
    end
  end
end
