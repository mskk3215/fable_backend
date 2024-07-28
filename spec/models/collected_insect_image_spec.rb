# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectedInsectImage do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:collected_insect) { create(:collected_insect, user:, post:) }
  let(:image) { build(:collected_insect_image, image: File.open('public/images/test_image.png'), collected_insect:) }

  describe '画像投稿' do
    subject(:valid_image) { image.valid? }

    context '投稿できる場合' do
      it 'imageがあれば投稿できる' do
        expect(valid_image).to be true
      end
    end

    context '投稿できない場合' do
      it 'imageが空では投稿できない' do
        image.image = nil
        expect(valid_image).to be false
        expect(image.errors.full_messages).to include("Image can't be blank")
      end

      it '紐づくCollectedInsectが存在しないと投稿できない' do
        image.collected_insect = nil
        expect(valid_image).to be false
        expect(image.errors.full_messages).to include('Collected insect must exist')
      end
    end
  end
end
