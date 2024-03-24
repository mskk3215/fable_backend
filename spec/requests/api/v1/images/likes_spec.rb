# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Images::Likes' do
  let(:user) { create(:user) }
  let(:new_image) { create(:image) }

  before do
    login(user)
  end

  describe 'POST /api/v1/images/:image_id/likes' do
    it '画像に対するいいねを作成する' do
      expect {
        post api_v1_image_likes_path(image_id: new_image.id)
      }.to change(Like, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(json['added']).to be true
    end
  end

  describe 'DELETE /api/v1/images/:image_id/likes/:id' do
    let!(:like) { create(:like, user:, image: new_image) }

    it '画像に対するいいねを削除する' do
      expect {
        delete api_v1_image_like_path(image_id: new_image.id, id: like.id)
      }.to change(Like, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(json['removed']).to be true
    end
  end
end
