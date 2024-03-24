# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'フォロー機能' do
    before do
      follower = FactoryBot.create(:user)
      followed = FactoryBot.create(:user)
      @relationship = FactoryBot.build(:relationship, follower:, followed:)
    end

    context 'フォローできる場合' do
      it 'follower_idとfollowed_idがあればフォローできる' do
        expect(@relationship).to be_valid
      end
    end

    context 'フォローできない場合' do
      it 'follower_idがないとフォローできない' do
        @relationship.follower_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include('Follower must exist')
      end
      
      it 'followed_idがないとフォローできない' do
        @relationship.followed_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include('Followed must exist')
      end
    end
  end
end
