# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectedInsectImageForm, type: :model do
  describe '#save' do
    # データベースのセットアップ
    let!(:insect) { create(:insect, name: 'カブトムシ', sex: 'オス') }
    let!(:prefecture) { create(:prefecture, name: '東京都') }
    let!(:city) { create(:city, name: '渋谷区', prefecture:) }
    let!(:park) { create(:park, name: '代々木公園', city:) }
    # imageのセットアップ
    let(:user) { create(:user) }
    let(:image) { create(:collected_insect_image, user:) }

    context '有効な画像パラメータが与えられた場合' do
      let(:collected_insect_image_params) do
        {
          name: 'カブトムシ',
          sex: 'オス',
          prefecture_name: '東京都',
          city_name: '渋谷区',
          park_name: '代々木公園',
          taken_at: '2023-03-14'
        }
      end
      let(:form) { described_class.new(collected_insect_images: [image], collected_insect_image_params:) }

      it '画像データが正しく更新されること' do
        expect(form.save).to be true
        image.reload
        expect(image.insect.name).to eq 'カブトムシ'
        expect(image.insect.sex).to eq 'オス'
        expect(image.city.prefecture.name).to eq '東京都'
        expect(image.city.name).to eq '渋谷区'
        expect(image.park.name).to eq '代々木公園'
        expect(image.taken_at.to_date).to eq Date.new(2023, 3, 14)
      end
    end

    context '無効な画像パラメータが与えられた場合' do
      scenarios = [
        { name: 'park_nameがあってcity_nameがない場合', params: { name: 'カブトムシ', sex: 'オス', park_name: '代々木公園', taken_at: '2023-03-14' } },
        { name: 'nameがあってsexがない場合', params: { name: 'カブトムシ', city_name: '渋谷区', park_name: '代々木公園', taken_at: '2023-03-14' } },
        { name: 'sexがあってnameがない場合', params: { sex: 'オス', city_name: '渋谷区', park_name: '代々木公園', taken_at: '2023-03-14' } }
      ]
      let(:form) { described_class.new(collected_insect_images: [image], collected_insect_image_params: invalid_image_params) }

      scenarios.each do |scenario|
        context scenario[:name] do
          let(:form) { described_class.new(collected_insect_images: [image], collected_insect_image_params: scenario[:params]) }

          it '更新が失敗すること' do
            expect(form.save).to be false
          end
        end
      end
    end
  end
end
