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

  # Postモデルのクラスメソッドに対するテスト
  describe '.fetch_all_with_includes' do
    it '全ての画像と関連データを含めて、作成日の降順で取得する' do
      # テストデータのセットアップ
      older_post = create(:post, created_at: 2.days.ago)
      newer_post = create(:post, created_at: 1.day.ago)
      create_list(:image, 3, user:, post: older_post)
      create_list(:image, 2, user:, post: newer_post)

      # メソッド実行
      results = Post.fetch_all_with_includes
      # 降順に取得されているか検証
      expect(results.to_a).to eq([newer_post, older_post])
      expect(results.first.images.size).to eq(2)
      expect(results.second.images.size).to eq(3)
      # 関連データが含まれているか検証
      expect(results.first.images.first.user).not_to be_nil
    end
  end

  describe '.for_followed_users' do
    it 'フォローしているユーザーの投稿のみ取得する' do
      # テストデータのセットアップ
      followed_user = create(:user)
      user.following << followed_user
      create(:post, user: followed_user) # フォローしているユーザーの投稿
      create(:post, user: create(:user)) # フォローしていないユーザーの投稿

      # メソッド実行
      results = Post.for_followed_users(user)

      # 期待値の検証
      expect(results.size).to eq(1)
      expect(results.first.user).to eq(followed_user)
    end
  end

  describe '.from_the_last_week' do
    it '1週間以内に作成された投稿を取得する' do
      # テストデータのセットアップ
      create(:post, created_at: 2.weeks.ago)
      post_from_last_week = create(:post, created_at: 3.days.ago)

      # メソッド実行
      results = Post.from_the_last_week

      # 期待値の検証
      expect(results).to include(post_from_last_week)
      expect(results.size).to eq(1)
    end
  end

  describe '.sort_by_likes_with_minimum_five' do
    it 'いいねが5以上の投稿をいいねの多い順に取得する' do
      # テストデータのセットアップ
      post_with_few_likes = create(:post)
      create_list(:like, 4, image: create(:image, post: post_with_few_likes))

      post_with_many_likes = create(:post)
      create_list(:like, 6, image: create(:image, post: post_with_many_likes))

      # メソッド実行
      results = Post.sort_by_likes_with_minimum_five

      # 期待値の検証
      expect(results.first).to eq(post_with_many_likes)
      expect(results.size).to eq(1)
    end
  end
end
