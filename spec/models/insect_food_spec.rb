# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InsectFood do
  let(:insect) { create(:insect) }
  let(:food) { create(:food) }
  let(:insect_food) { InsectFood.new(insect:, food:) }

  describe 'バリデーションの確認' do
    it 'insectとfoodがある場合は有効である' do
      insect = create(:insect)
      food = create(:food)
      insect_food = InsectFood.new(insect:, food:)
      expect(insect_food).to be_valid
    end

    it 'insectがない場合は無効である' do
      food = create(:food)
      insect_food = InsectFood.new(insect: nil, food:)
      expect(insect_food).not_to be_valid
      expect(insect_food.errors[:insect]).to include('must exist')
    end

    it 'foodがない場合は無効である' do
      insect = create(:insect)
      insect_food = InsectFood.new(insect:, food: nil)
      expect(insect_food).not_to be_valid
      expect(insect_food.errors[:food]).to include('must exist')
    end
  end

  describe 'アソシエーションの確認' do
    it 'insectに属していること' do
      expect(InsectFood.reflect_on_association(:insect).macro).to eq(:belongs_to)
    end

    it 'foodに属していること' do
      expect(InsectFood.reflect_on_association(:food).macro).to eq(:belongs_to)
    end
  end
end
