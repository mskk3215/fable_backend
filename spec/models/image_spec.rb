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
end
