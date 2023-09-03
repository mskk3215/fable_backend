# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいね機能' do
    before do
      user = FactoryBot.create(:user)
      image = FactoryBot.create(:image)
      @like = FactoryBot.build(:like, user_id: user.id, image_id: image.id)
    end

    context 'いいねできる場合' do
      it 'user_idとimage_idがあればいいねできる' do
        expect(@like).to be_valid
      end
    end

    context 'いいねできない場合' do
      it 'user_idがないといいねできない' do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('User must exist')
      end
      it 'image_idがないといいねできない' do
        @like.image_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Image must exist')
      end
    end
  end
end
