# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe '投稿機能' do
    let(:post) { FactoryBot.create(:post, user:) }

    context '投稿できる場合' do
      it 'user_idがあれば投稿できる' do
        expect(post).to be_valid
      end
    end

    context '投稿できない場合' do
      it '紐づくユーザーが存在しないと投稿できない' do
        post.user = nil
        post.valid?
        expect(post.errors.full_messages).to include('User must exist')
      end
    end
  end
end
