# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users' do
  describe 'GET /api/v1/users/:user_id' do
    let(:user) { create(:user) }

    context '自分自身の情報を要求する場合' do
      before do
        login(user)
      end

      it 'ユーザー情報を返す' do
        get api_v1_user_path(user.id)

        expect(response).to have_http_status(:ok)
        expect(json['user']['id']).to eq(user.id)
      end
    end

    context '他のユーザーの情報を要求する場合' do
      let(:other_user) { create(:user) }

      before do
        login(other_user)
      end

      it 'メールアドレスを除く他のユーザー情報を返す' do
        get api_v1_user_path(user.id)

        expect(response).to have_http_status(:ok)
        expect(json['user']['id']).to eq(user.id)
        expect(json['user']['email']).to be_nil
      end
    end
  end

  describe 'POST /api/v1/users' do
    let(:valid_attributes) { { user: { nickname: 'testuser', email: 'user@example.com', password: 'password' } } }
    let(:invalid_attributes) { { user: { nickname: '', email: 'user@example.com', password: 'password' } } }

    context '有効なパラメーターの場合' do
      it '新しいユーザーを作成する' do
        expect {
          post api_v1_users_path, params: valid_attributes
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:ok)
      end
    end

    context '無効なパラメーターの場合' do
      it '新しいユーザーを作成しない' do
        expect {
          post api_v1_users_path, params: invalid_attributes
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
