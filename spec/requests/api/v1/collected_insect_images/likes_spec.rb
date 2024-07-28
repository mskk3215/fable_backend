# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::CollectedInsectImages::Likes' do
  let(:user) { create(:user) }
  let(:collected_insect) { create(:collected_insect) }

  before do
    login(user)
  end

  describe 'POST /api/v1/collected_insects/:collected_insect_id/likes' do
    it 'collected_insectに対するいいねを作成する' do
      expect {
        post api_v1_collected_insect_likes_path(collected_insect_id: collected_insect.id)
      }.to change(Like, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(json['added']).to be true
    end
  end

  describe 'DELETE /api/v1/collected_insects/:collected_insect_id/likes/:id' do
    let!(:like) { create(:like, user:, collected_insect:) }

    it 'collected_insectに対するいいねを削除する' do
      expect {
        delete api_v1_collected_insect_like_path(collected_insect_id: collected_insect.id, id: like.id)
      }.to change(Like, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(json['removed']).to be true
    end
  end
end
