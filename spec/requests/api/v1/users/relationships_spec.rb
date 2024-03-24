# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users::Relationships' do
  describe 'POST /api/v1/users/:id/relationships' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'ログインしている場合' do
      before do
        login(user)
      end

      it 'ユーザーをフォローできること' do
        expect do
          post api_v1_user_relationships_path(user_id: user.id, id: other_user.id)
        end.to change(user.following, :count).by(1)
        expect(response).to have_http_status(:ok)
      end

      it '存在しないユーザーをフォローしようとするとエラーが返されること' do
        post api_v1_user_relationships_path(user_id: user.id, id: -1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /api/v1/users/:id/relationships' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      login(user)
      user.following << other_user
    end

    it 'ユーザーのフォローを解除できること' do
      expect do
        delete api_v1_user_relationship_path(user_id: user.id, id: other_user.id)
      end.to change(user.following, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
