# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Park, type: :model do
  let(:prefecture) { create(:prefecture) }
  let(:city) { create(:city, prefecture:) }
  let(:park_name) { '公園' }
  let(:park) { create(:park, name: park_name, city:) }

  describe '新規登録' do
    it '必要な情報があれば登録できる' do
      expect(park).to be_valid
    end

    it 'city_idが空では登録できない' do
      park.city_id = nil
      park.valid?
      expect(park.errors.full_messages).to include('City must exist')
    end

    it 'prefecture_idが空では登録できない' do
      park.prefecture_id = nil
      park.valid?
      expect(park.errors.full_messages).to include('Prefecture must exist')
    end
  end

  # Parkモデルのクラスメソッドに対するテスト
  describe '.find_or_create_park' do
    context '存在する公園名が与えられた場合' do
      it '既存の公園が返される' do
        existing_park = create(:park, name: park_name, city:)
        expect(Park.find_or_create_park(park_name, city)).to eq(existing_park)
      end
    end

    context '存在しない公園名が与えられた場合' do
      let(:new_park_name) { '新しい公園' }

      it '新しい公園が作成される' do
        expect { Park.find_or_create_park(new_park_name, city) }.to change(Park, :count).by(1)
      end

      it '新しく作成された公園が正しい市町村と県に関連付けられている' do
        new_park = Park.find_or_create_park('新しい公園', city)
        expect(new_park.city).to eq(city)
        expect(new_park.prefecture).to eq(city.prefecture)
      end
    end

    context '公園名がない場合' do
      it '公園名が空の場合はnilを返す' do
        expect(Park.find_or_create_park('', city)).to be_nil
      end
    end
  end
end
