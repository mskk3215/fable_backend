# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Insect do
  let(:insect) { create(:insect) }

  describe '.taken_amount_per_month' do
    before do
      (1..12).each do |month|
        create(:collected_insect, insect:, taken_date_time: DateTime.new(2023, month, 1))
      end
    end

    it '各月の撮影枚数が正しくカウントされること' do
      result = insect.taken_amount_per_month

      expect(result).to be_an(Array)
      expect(result.size).to eq(12)

      result.each_with_index do |data, index|
        expect(data[:month]).to eq(index + 1)
        expect(data[:count]).to eq(1)
      end
    end
  end

  describe '.taken_amount_per_hour' do
    before do
      (0..23).each do |hour|
        create(:collected_insect, insect:, taken_date_time: DateTime.new(2023, 1, 1, hour))
      end
    end

    it '3時間ごとの撮影枚数が正しくカウントされること' do
      result = insect.taken_amount_per_hour

      expect(result).to be_an(Array)
      expect(result.size).to eq(8)

      result.each_with_index do |data, index|
        start_hour = index * 3
        end_hour = start_hour + 2
        expect(data[:time_slot]).to eq("#{start_hour}:00 - #{end_hour}:59")
        expect(data[:count]).to eq(3)
      end
    end
  end
end
