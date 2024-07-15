# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいね機能' do
    before do
      user = FactoryBot.create(:user)
      collected_insect_image = FactoryBot.create(:collected_insect_image)
      @like = FactoryBot.build(:like, user_id: user.id, collected_insect_image_id: collected_insect_image.id)
    end

    context 'いいねできる場合' do
      it 'user_idとcollected_insect_image_idがあればいいねできる' do
        expect(@like).to be_valid
      end
    end

    context 'いいねできない場合' do
      it 'user_idがないといいねできない' do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('User must exist')
      end
      it 'collected_insect_image_idがないといいねできない' do
        @like.collected_insect_image_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Collected insect image must exist')
      end
    end
  end
end
