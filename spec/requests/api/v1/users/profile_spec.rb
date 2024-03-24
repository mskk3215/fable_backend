# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users::Profile' do
  describe 'PATCH /api/v1/users/:user_id/profile' do
    let(:user) { create(:user) }
    let(:file) { Rack::Test::UploadedFile.new(Rails.public_path.join('images/test_image.png'), 'image/png') }
    let(:valid_attributes) { { user: { nickname: 'NewNickname', email: 'newemail@example.com', avatar: file } } }
    let(:invalid_attributes) { { user: { nickname: '', email: 'invalidemail', avatar: '' } } }

    context 'ユーザーがログインしている場合' do
      before do
        login(user)
      end

      context '有効なパラメーターを送信したとき' do
        it 'ユーザーのプロフィールを更新する' do
          patch api_v1_user_profile_path(user.id), params: valid_attributes
          user.reload
          expect(user.nickname).to eq('NewNickname')
          expect(user.email).to eq('newemail@example.com')
          expect(user.avatar.url).to include('test_image.png')
          expect(response).to have_http_status(:ok)
        end
      end

      context '無効なパラメーターを送信したとき' do
        it 'ユーザーのプロフィールを更新しない' do
          patch api_v1_user_profile_path(user.id), params: invalid_attributes
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'ユーザーがログインしていない場合' do
      it '未認証であることを返す' do
        patch api_v1_user_profile_path(user.id), params: valid_attributes
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
