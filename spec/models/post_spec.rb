# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post, user_id: user.id)
  end

  describe '投稿機能' do
    context '投稿できる場合' do
      it 'user_idがあれば投稿できる' do
        expect(@post).to be_valid
      end
    end

    context '投稿できない場合' do
      it '紐づくユーザーが存在しないと投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('User must exist')
      end
    end
  end
end
