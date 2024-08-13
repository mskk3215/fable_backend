# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SightingNotifications', type: :request do
  let(:user) { create(:user) }
  let(:insect) { create(:insect) }
  let(:park) { create(:park) }
  let(:collected_insect) { create(:collected_insect, insect:, park:) }
  let!(:sighting_notification) { create(:sighting_notification, user:, collected_insect:) }

  before do
    login(user)
  end

  describe 'GET /index' do
    context '特定の昆虫の通知を取得する場合' do
      before do
        get api_v1_sighting_notifications_path, params: { insect_id: insect.id }
      end

      it '成功したレスポンスを返す' do
        expect(response).to have_http_status(:ok)
      end

      it '期待される通知を返す' do
        expect(json_response).to be_an_instance_of(Array)
        expect(json_response.first['insect_id']).to eq(insect.id)
                expect(json_response.first['insect_name']).to eq(insect.name)
        expect(json_response.first['park_name']).to eq(park.name)
      end
    end

    context '未読の通知を取得する場合' do
      before do
        get api_v1_sighting_notifications_path, params: { icon_button: true }
      end

      it '成功したレスポンスを返す' do
        expect(response).to have_http_status(:ok)
      end

      it '未読の通知を返す' do
        expect(json_response).to be_an_instance_of(Array)
        expect(json_response.first['is_read']).to be false
      end
    end

    context '現在のユーザーの通知を取得する場合' do
      before do
        get api_v1_sighting_notifications_path
      end

      it '成功したレスポンスを返す' do
        expect(response).to have_http_status(:ok)
      end

      it '期待される通知を返す' do
        expect(json_response).to be_an_instance_of(Array)
        expect(json_response.first['insect_name']).to eq(insect.name)
        expect(json_response.first['park_name']).to eq(park.name)
        expect(json_response.first['is_read']).to be true
      end
    end
  end

end

def json_response
  response.parsed_body
end
