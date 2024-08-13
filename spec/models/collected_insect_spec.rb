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

  describe '#create_sighting_notifications_if_recent_and_insect_changed' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:insect) { create(:insect) }
    let(:park) { create(:park) }
    let(:collected_insect) { create(:collected_insect, user:, insect:, park:, created_at: Time.current) }
    let!(:sighting_notification_setting) { create(:sighting_notification_setting, user: another_user, insect:) }

    before do
      allow(collected_insect).to receive_messages(saved_change_to_insect_id?: true, saved_change_to_taken_date_time?: true, saved_change_to_park_id?: true)
    end

    context '条件が満たされた場合' do
      it '新しい通知を作成する' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.to change(SightingNotification, :count).by(1)

        notification = SightingNotification.last
        expect(notification.user_id).to eq(another_user.id)
        expect(notification.collected_insect_id).to eq(collected_insect.id)
        expect(notification.is_read).to be_falsey
      end
    end

    context 'insect_idが変更されていない場合' do
      before do
        allow(collected_insect).to receive(:saved_change_to_insect_id?).and_return(false)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context 'taken_date_timeが変更されていない場合' do
      before do
        allow(collected_insect).to receive(:saved_change_to_taken_date_time?).and_return(false)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context 'park_idが変更されていない場合' do
      before do
        allow(collected_insect).to receive(:saved_change_to_park_id?).and_return(false)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context 'ポストが1時間以上前に作成された場合' do
      before do
        collected_insect.update(created_at: 2.hours.ago)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context 'ユーザーが設定されたユーザーと同じ場合' do
      let(:collected_insect) { create(:collected_insect, user: another_user, insect:, park:, created_at: Time.current) }

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(another_user)
        }.not_to(change(SightingNotification, :count))
      end
    end
  end
end
