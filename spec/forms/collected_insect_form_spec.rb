# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectedInsectForm, type: :model do
  describe '#save' do
    # データベースのセットアップ
    let!(:insect) { create(:insect, name: 'カブトムシ') }
    let!(:collected_insect) { create(:collected_insect, sex: 'オス', insect:) }
    let!(:prefecture) { create(:prefecture, name: '東京都') }
    let!(:city) { create(:city, name: '渋谷区', prefecture:) }
    let!(:park) { create(:park, name: '代々木公園', city:) }
    # imageのセットアップ
    let!(:image) { create(:collected_insect_image, collected_insect:) }

    context '有効な画像パラメータが与えられた場合' do
      let(:collected_insect_params) do
        {
          name: 'カブトムシ',
          sex: 'オス',
          prefecture_name: '東京都',
          city_name: '渋谷区',
          park_name: '代々木公園',
          taken_date_time: '2023-03-14'
        }
      end

      before do
        collected_insect.save!
        image.save!
      end

      it '画像データが正しく更新されること' do
        form = described_class.new(collected_insects: [collected_insect], collected_insect_params:)
        result = form.save
        if result
          expect(result).to be true
          collected_insect.reload
          expect(collected_insect.insect.name).to eq 'カブトムシ'
          expect(collected_insect.sex).to eq 'オス'
          expect(collected_insect.city.prefecture.name).to eq '東京都'
          expect(collected_insect.city.name).to eq '渋谷区'
          expect(collected_insect.park.name).to eq '代々木公園'
          expect(collected_insect.taken_date_time.to_date).to eq Date.new(2023, 3, 14)
        else
          puts form.errors.full_messages
          expect(result).to be true
        end
      end
    end

    context '無効な画像パラメータが与えられた場合' do
      scenarios = [
        { name: 'park_nameがあってcity_nameがない場合', params: { name: 'カブトムシ', sex: 'オス', park_name: '代々木公園', taken_date_time: '2023-03-14' } },
        { name: 'nameがあってsexがない場合', params: { name: 'カブトムシ', city_name: '渋谷区', park_name: '代々木公園', taken_date_time: '2023-03-14' } },
        { name: 'sexがあってnameがない場合', params: { sex: 'オス', city_name: '渋谷区', park_name: '代々木公園', taken_date_time: '2023-03-14' } }
      ]
      before do
        collected_insect.save!
        image.save!
      end

      scenarios.each do |scenario|
        context scenario[:name] do
          let(:invalid_image_params) { scenario[:params] }

          it '更新が失敗すること' do
            form = described_class.new(collected_insects: [collected_insect], collected_insect_params: invalid_image_params)
            expect(form.save).to be false
          end
        end
      end
    end
  end
end
