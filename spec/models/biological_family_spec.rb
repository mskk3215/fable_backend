# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BiologicalFamily do
  describe 'バリデーションの確認' do
    it '名前がある場合は有効である' do
      biological_family = BiologicalFamily.new(name: 'コガネムシ科')
      expect(biological_family).to be_valid
    end

    it '名前がない場合は無効である' do
      biological_family = BiologicalFamily.new(name: nil)
      expect(biological_family).not_to be_valid
      expect(biological_family.errors.messages[:name]).to include("can't be blank")
    end
  end
end
