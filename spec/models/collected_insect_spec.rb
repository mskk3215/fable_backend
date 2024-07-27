# frozen_string_literal: true

# spec/models/collected_insect_spec.rb
require 'rails_helper'

RSpec.describe CollectedInsect do
  let(:insect) { create(:insect) }
  let(:collected_insect) { build(:collected_insect, insect:) }

  describe 'バリデーションのテスト' do
    it '性別がある場合、有効であること' do
      expect(collected_insect).to be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    it 'insectに属していること' do
      expect(collected_insect.insect).to eq(insect)
    end

    it 'collected_insect_imagesを持っていること' do
      expect(collected_insect).to respond_to(:collected_insect_image)
    end
  end

  # coolected_insectのモデルメソッドに対するテスト
  describe '#set_default_likes_count' do
    it '新規レコードのlikes_countがデフォルトで0になっている' do
      new_image = build(:collected_insect)
      expect(new_image.likes_count).to eq(0)
    end
  end

  describe '#destroy_parent_post_if_no_collected_insects' do
    it 'collected_insectが0になったらポストも削除される' do
      collected_insect.save!
      expect { collected_insect.destroy }.to change(Post, :count).by(-1)
    end
  end

  describe '.sort_by_option' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user:) }

    before do
      3.times do
        create(:collected_insect, user:, post:, likes_count: rand(1..10))
      end
    end

    it 'オプション0で作成日時の降順に並べ替える' do
      expect(CollectedInsect.sort_by_option(0)).to eq(CollectedInsect.order(created_at: :desc))
    end

    it 'オプション1で撮影日時の降順に並べ替える' do
      expect(CollectedInsect.sort_by_option(1)).to eq(CollectedInsect.order(taken_date_time: :desc))
    end

    it 'オプション2でいいね数の降順に並べ替える' do
      expect(CollectedInsect.sort_by_option(2)).to eq(CollectedInsect.order(likes_count: :desc))
    end
  end
end
