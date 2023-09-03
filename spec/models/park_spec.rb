# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Park, type: :model do
  before do
    @park = FactoryBot.create(:park)
  end

  describe 'park新規登録' do
    context 'parkを保存できる場合' do
      it 'name,city_id,prefecture_idがあれば保存できる' do
        expect(@park).to be_valid
      end
    end

    context 'parkを保存できない場合' do
      it 'nameが空では保存できない' do
        @park.name = nil
        @park.valid?
        expect(@park.errors.full_messages).to include("Name can't be blank")
      end
      it 'city_idが空では保存できない' do
        @park.city_id = nil
        @park.valid?
        expect(@park.errors.full_messages).to include("City can't be blank")
      end
      it 'prefecture_idが空では保存できない' do
        @park.prefecture_id = nil
        @park.valid?
        expect(@park.errors.full_messages).to include("Prefecture can't be blank")
      end
    end
  end
end
