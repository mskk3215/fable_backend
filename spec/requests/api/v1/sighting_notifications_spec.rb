# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SightingNotifications' do
  let(:user) { create(:user) }
  let(:insect) { create(:insect) }
  let(:park) { create(:park) }
  let(:collected_insect) { create(:collected_insect, insect:, park:) }
  let!(:sighting_notification) { create(:sighting_notification, user:, collected_insect:, is_read: false) }

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
        expect(json_response).to be_an_instance_of(Array)
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
        expect(json_response).to be_an_instance_of(Array)
        expect(json_response.first['insect_name']).to eq(insect.name)
        expect(json_response.first['park_name']).to eq(park.name)
      end
    end
  end

  describe 'PATCH /mark_all_as_read' do
    context '未読の通知が存在する場合' do
      it '全ての未読通知を既読にする' do
        expect {
          put api_v1_sighting_notifications_mark_all_as_read_path
        }.to change { user.sighting_notifications.where(is_read: false).count }.from(1).to(0)

        expect(response).to have_http_status(:ok)
        expect(json_response['status']).to eq('updated')
      end
    end

    context '更新が失敗する場合' do
      let(:unread_notification) { create(:sighting_notification, user:, is_read: false) }

      before do
        allow(ActiveRecord::Base).to receive(:transaction).and_raise(ActiveRecord::RecordInvalid.new(unread_notification))
      end

      it 'エラーメッセージを返す' do
        put api_v1_sighting_notifications_mark_all_as_read_path

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['error']).to eq(['Failed to mark notifications as read'])
      end
    end
  end
end

def json_response
  response.parsed_body
end
