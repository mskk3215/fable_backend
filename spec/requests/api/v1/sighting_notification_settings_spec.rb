# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SightingNotificationSettings' do
  let(:user) { create(:user) }
  let(:insect) { create(:insect) }
  let(:park) { create(:park) }
  let!(:sighting_notification_setting) { create(:sighting_notification_setting, user:, insect:) }
  let!(:collected_insects) { create_list(:collected_insect, 5, insect:, park:) }

  before do
    login(user)
  end

  describe 'GET /index' do
    context '特定の昆虫に対しての投稿通知設定の取得' do
      it '正しい通知を返す' do
        get api_v1_sighting_notification_settings_path
        expect(response).to have_http_status(:ok)
        expect(json).to be_an(Array)
        expect(json.size).to eq(1)
      end
    end
  end

  describe 'POST /create' do
    context '有効なパラメータの場合' do
      it '新しい通知を作成する' do
        new_insect = create(:insect)
        expect {
          post api_v1_sighting_notification_settings_path, params: { insect_id: new_insect.id }
        }.to change(SightingNotificationSetting, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context '無効なパラメータの場合' do
      it '無効なinsect_idが与えられた場合、エラーを返す' do
        post api_v1_sighting_notification_settings_path, params: { insect_id: -1 }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['error']).to include(['Insect must exist'])
      end

      it 'insect_idが欠落している場合、エラーを返す' do
        post api_v1_sighting_notification_settings_path, params: {}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['error']).to include(['Insect must exist'])
      end
    end
  end

  describe 'DELETE /destroy' do
    it '指定された通知を削除する' do
      expect {
        delete api_v1_sighting_notification_setting_path(sighting_notification_setting)
      }.to change(SightingNotificationSetting, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it '通知が削除できない場合、エラーを返す' do
      non_existent_id = 9999
      delete api_v1_sighting_notification_setting_path(non_existent_id)
      expect(response).to have_http_status(:not_found)
    end
  end

  def json
    response.parsed_body
  end
end
