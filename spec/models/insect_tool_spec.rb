# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InsectTool do
  let(:insect) { create(:insect) }
  let(:tool) { create(:tool) }
  let(:insect_tool) { InsectTool.new(insect:, tool:) }

  describe 'バリデーションの確認' do
    it 'insectとtoolがある場合は有効である' do
      insect = create(:insect)
      tool = create(:tool)
      insect_tool = InsectTool.new(insect:, tool:)
      expect(insect_tool).to be_valid
    end

    it 'insectがない場合は無効である' do
      tool = create(:tool)
      insect_tool = InsectTool.new(insect: nil, tool:)
      expect(insect_tool).not_to be_valid
      expect(insect_tool.errors[:insect]).to include('must exist')
    end

    it 'toolがない場合は無効である' do
      insect = create(:insect)
      insect_tool = InsectTool.new(insect:, tool: nil)
      expect(insect_tool).not_to be_valid
      expect(insect_tool.errors[:tool]).to include('must exist')
    end
  end

  describe 'アソシエーションの確認' do
    it 'insectに属していること' do
      expect(InsectTool.reflect_on_association(:insect).macro).to eq(:belongs_to)
    end

    it 'toolに属していること' do
      expect(InsectTool.reflect_on_association(:tool).macro).to eq(:belongs_to)
    end
  end
end
