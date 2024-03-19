# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user:) }
  let(:image) { FactoryBot.build(:image, image_path: 'public/images/test_image.png', user:, post:) }

  describe '画像投稿' do
    subject { image.valid? }

    context '投稿できる場合' do
      it 'imageがあれば投稿できる' do
        expect(subject).to be true
      end
    end

    context '投稿できない場合' do
      it 'imageが空では投稿できない' do
        image.image = nil
        expect(subject).to be false
        expect(image.errors.full_messages).to include("Image can't be blank")
      end

      it '紐づくユーザーが存在しないと投稿できない' do
        image.user = nil
        expect(subject).to be false
        expect(image.errors.full_messages).to include('User must exist')
      end
    end
  end

  # Imageのモデルメソッドに対するテスト
  describe '#set_default_likes_count' do
    it '新規レコードのlikes_countがデフォルトで0になっている' do
      new_image = build(:image)
      expect(new_image.likes_count).to eq(0)
    end
  end

  describe '#destroy_parent_post_if_no_images' do
    it '画像が0枚になったらポストも削除される' do
      image.save!
      image.destroy
      expect { post.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '.sort_by_option' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user:) }

    before do
      3.times do
        FactoryBot.create(:image, user:, post:, likes_count: rand(1..10))
      end
    end

    it 'オプション0で作成日時の降順に並べ替える' do
      expect(Image.sort_by_option(0)).to eq(Image.order(created_at: :desc))
    end

    it 'オプション1で撮影日時の降順に並べ替える' do
      expect(Image.sort_by_option(1)).to eq(Image.order(taken_at: :desc))
    end

    it 'オプション2でいいね数の降順に並べ替える' do
      expect(Image.sort_by_option(2)).to eq(Image.order(likes_count: :desc))
    end
  end
end
