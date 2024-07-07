# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HabitatPlace do
  describe 'バリデーションの確認' do
    it '名前がある場合は有効である' do
      habitat_place = HabitatPlace.new(name: '生息場所')
      expect(habitat_place).to be_valid
    end

    it '名前がない場合は無効である' do
      habitat_place = HabitatPlace.new(name: nil)
      expect(habitat_place).not_to be_valid
      expect(habitat_place.errors.messages[:name]).to include("can't be blank")
    end
  end
end
