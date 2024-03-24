# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Insects' do
  let(:new_user1) { create(:user) }
  let(:new_user2) { create(:user) }
  let(:new_prefecture) { create(:prefecture) }
  let(:new_city) { create(:city, prefecture: new_prefecture) }
  let(:new_park) { create(:park, city: new_city) }
  let!(:new_insects1) { create_list(:insect, 10) }
  let!(:new_insects2) { create(:insect, name: 'カブトムシ') }

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
        login(new_user1)
        create(:image, user: new_user1, insect: new_insects1.first, park: new_park)
      end

      it '採集済み昆虫のリストを正しく取得できること' do
        get api_v1_insects_path(status: 'collected')

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(1)
        expect(json.first['insect_name']).to include(new_insects1.first.name)
      end
    end

    context '未採集昆虫のリストを取得する場合' do
      before do
        login(new_user2)
        create(:image, user: new_user2, insect: new_insects2, park: new_park)
        new_insects1.each do |insect|
          create(:image, user: new_user1, insect:, park: new_park)
        end
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
        login(new_user2)

        create(:image, user: new_user2, insect: new_insects2, park: new_park)
        new_insects1.each do |insect|
          create(:image, user: new_user1, insect:, park: new_park)
        end
      end

      it '採集済みと未採集の昆虫の間に重複がないこと' do
        get api_v1_insects_path(status: 'collected'), params: { user_id: new_user2.id }
        collected_insects_ids = json.pluck('id')

        get api_v1_insects_path(status: 'uncollected'), params: { user_id: new_user2.id }
        uncollected_insects_ids = json.pluck('id')

        expect(collected_insects_ids & uncollected_insects_ids).to be_empty
      end
    end
  end
end
