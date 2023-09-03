# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  before do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user_id: user.id)
    @image = FactoryBot.build(:image, image_path: 'public/images/test_image.png', user_id: user.id, post_id: post.id)
  end

  describe do
    context '投稿できる場合' do
      it 'imageがあれば投稿できる' do
        expect(@image).to be_valid
      end
    end

    context '投稿できない場合' do
      it 'imageが空では投稿できない' do
        @image.image = nil
        @image.valid?
        expect(@image.errors.full_messages).to include("Image can't be blank")
      end

      it '紐づくユーザーが存在しないと投稿できない' do
        @image.user = nil
        @image.valid?
        expect(@image.errors.full_messages).to include('User must exist')
      end
    end
  end
end
