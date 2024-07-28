# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }
    let!(:posts) { create_list(:post, 10, user:) }

    before do
      login(user)
    end

    context 'tab_valueが0の場合' do
      before { get api_v1_posts_path, params: { tab_value: 0, page: 1 } }

      it '正しい数の投稿が返されること' do
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq(2)
      end
    end
  end

  describe 'POST /api/v1/posts' do
    let(:user) { create(:user) }
    let(:image_file) { Rack::Test::UploadedFile.new(Rails.public_path.join('images/test_image.png'), 'image/png') }
    let(:valid_attributes) {
      {
        images: [image_file]
      }
    }
    let(:invalid_attributes) {
      { images: nil }
    }

    context 'ログインしているユーザーの場合' do
      before do
        login(user)
      end

      context '有効なパラメータの場合' do
        it '新しい投稿を作成する' do
          expect {
            post api_v1_posts_path, params: { collected_insect: valid_attributes }
          }.to change(Post, :count).by(1)
          expect(response).to have_http_status(:created)
        end
      end

      context '無効なパラメータの場合' do
        it '投稿が作成されない' do
          expect {
            post api_v1_posts_path, params: { collected_insect: invalid_attributes }
          }.not_to change(Post, :count)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'ログインしていない場合' do
      it '認証エラーを返す' do
        post api_v1_posts_path, params: { post: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/posts/:id' do
    let(:user) { create(:user) }
    let!(:new_post) { create(:post, user:) }

    context 'ログインしているユーザーの場合' do
      before do
        login(user)
      end

      it '投稿を削除できる' do
        expect(response).to have_http_status(:ok)

        expect {
          delete api_v1_post_path(new_post.id)
        }.to change(Post, :count).by(-1)
      end
    end

    context 'ログインしていない場合' do
      it '認証エラーを返す' do
        delete api_v1_post_path(new_post.id)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
