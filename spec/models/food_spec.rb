# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Food do
  describe 'バリデーションの確認' do
    it '名前がある場合は有効である' do
      food = Food.new(name: '樹液')
      expect(food).to be_valid
    end

    it '名前がない場合は無効である' do
      food = Food.new(name: nil)
      expect(food).not_to be_valid
      expect(food.errors.messages[:name]).to include("can't be blank")
    end
  end
end
