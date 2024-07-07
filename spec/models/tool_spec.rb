# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tool do
  describe 'バリデーションの確認' do
    it '名前がある場合は有効である' do
      tool = Tool.new(name: '網')
      expect(tool).to be_valid
    end

    it '名前がない場合は無効である' do
      tool = Tool.new(name: nil)
      expect(tool).not_to be_valid
      expect(tool.errors.messages[:name]).to include("can't be blank")
    end
  end
end
