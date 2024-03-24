# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions' do
  describe 'POST /api/v1/login' do
    let(:user) { create(:user) }

    context '有効なログイン情報が提供された場合' do
      before { post api_v1_login_path, params: { session: { email: user.email, password: user.password } } }

      it 'ステータスコード200を返す' do
        expect(response).to have_http_status(:ok)
      end

      it 'ユーザーをログインする' do
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context '無効なログイン情報が提供された場合' do
      before { post api_v1_login_path, params: { session: { email: user.email, password: 'invalidpassword' } } }

      it 'ステータスコード401を返す' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']).to include('ログインに失敗しました。', '入力した情報を確認して再度お試しください。')
      end
    end
  end

  describe 'DELETE /api/v1/logout' do
    it 'ユーザーをログアウトする' do
      delete api_v1_logout_path
      expect(session[:user_id]).to be_nil
    end
  end

  describe 'GET /api/v1/logged_in' do
    let(:user) { create(:user) }

    context 'ユーザーがログインしている場合' do
      before do
        login(user)
        get api_v1_logged_in_path
      end

      it 'ステータスコード200を返す' do
        expect(response).to have_http_status(:ok)
      end

      it 'ログインしているユーザー情報を返す' do
        expect(json['logged_in']).to be_truthy
      end
    end

    context 'ユーザーがログインしていない場合' do
      before { get api_v1_logged_in_path }

      it 'ステータスコード200を返す' do
        expect(response).to have_http_status(:ok)
      end

      it 'ログインしていないというメッセージを返す' do
        expect(json['logged_in']).to be_falsey
        expect(json['message']).to eq('ユーザーが存在しません')
      end
    end
  end
end
