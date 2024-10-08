# frozen_string_literal: true

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

  # collected_insectのモデルメソッドに対するテスト
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
    let(:collected_insect) { create(:collected_insect, user:, insect:, park:, taken_date_time: Time.current, created_at: Time.current) }
    let!(:sighting_notification_setting) { create(:sighting_notification_setting, user: another_user, insect:) }

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

    context 'insect_idが存在しない場合' do
      before do
        collected_insect.update(insect_id: nil)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context 'taken_date_timeが存在しない場合' do
      before do
        collected_insect.update(taken_date_time: nil)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context 'park_idが存在しない場合' do
      before do
        collected_insect.update(park_id: nil)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context '投稿が25時間以上前の場合' do
      before do
        collected_insect.update(created_at: 25.hours.ago)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context '撮影日時が1週間以上前の場合' do
      before do
        collected_insect.update(taken_date_time: 2.weeks.ago)
      end

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context '通知ユーザーが設定されたユーザーと同じ場合' do
      let(:collected_insect) { create(:collected_insect, user: another_user, insect:, park:, created_at: Time.current) }

      it '通知を作成しない' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(another_user)
        }.not_to(change(SightingNotification, :count))
      end
    end

    context '既存の通知がある場合' do
      let!(:existing_notification) { create(:sighting_notification, user: another_user, collected_insect:) }

      it '通知を更新し、既読を未読に変更する' do
        expect {
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(user)
        }.not_to change(SightingNotification, :count)

        existing_notification.reload
        expect(existing_notification.is_read).to be_falsey
        expect(existing_notification.updated_at).to be_within(1.second).of(Time.current)
      end
    end
  end
end
