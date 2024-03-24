# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'パスワード更新' do
  let!(:user) { create(:user, password: 'old_password') }

  before do
    login(user)
  end

  describe 'PATCH /api/v1/users/password' do
    context '有効なパラメーターの場合' do
      before do
        patch api_v1_user_password_path(user),
              params: {
                user: {
                  password: 'old_password',
                  new_password: 'new_password'
                }
              }
      end

      it 'パスワードが更新されること' do
        expect(user.reload.authenticate('new_password')).to be_truthy
      end

      it 'ステータスコード200を返すこと' do
        expect(response).to have_http_status(:ok)
      end
    end

    context '現在のパスワードが無効の場合' do
      before do
        patch api_v1_user_password_path(user),
              params: {
                user: {
                  password: 'incorrect_password',
                  new_password: 'new_password'
                }
              }
      end

      it 'パスワードは更新されないこと' do
        expect(user.reload.authenticate('new_password')).to be_falsey
      end

      it 'ステータスコード422を返すこと' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'エラーメッセージを返すこと' do
        expect(json['errors']).to include('現在のパスワードが間違っています')
      end
    end
  end
end
