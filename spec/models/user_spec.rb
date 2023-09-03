# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      # カラムが空では登録できないことのテスト
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      # passwordの文字数と確認用passwordの不一致のテスト
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      # nicknameとemailの一意性のテスト
      it 'nicknameが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, nickname: @user.nickname)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Nickname has already been taken')
      end
      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      # emailの@の有無のテスト
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
    end
  end

  describe 'パスワードのハッシュ化' do
    before do
      @user.save
    end
    it '平文のパスワードと保存されているパスワードハッシュが一致する' do
      expect(@user.authenticate(@user.password)).to eq(@user)
    end

    it '平文のパスワードと保存されているパスワードハッシュが一致しない' do
      expect(@user.authenticate('password')).to eq(false)
    end
  end

  describe 'アバター画像のアップロード' do
    before do
      @uploader = AvatarUploader.new(@user, :avatar)
      # 画像処理有効かつ画像ファイルをアップロード
      AvatarUploader.enable_processing = true
      File.open(Rails.root.join('public', 'images', 'test_image.png')) { |f| @uploader.store!(f) }
    end
    after do
      # 画像処理無効化かつ画像ファイルを削除
      AvatarUploader.enable_processing = false
      @uploader.remove!
    end

    context 'アバター画像が登録できる場合' do
      it 'jpg, jpeg, gif, png, heif, heicの拡張子であれば登録できる' do
        extensions = %w[jpg jpeg gif png heif heic]
        extensions.each do |extension|
          expect(@uploader.extension_allowlist).to include(extension)
        end
      end
    end

    context 'アバター画像が登録できない場合' do
      it 'jpg, jpeg, gif, png, heif, heicの拡張子出なければ登録できない' do
        expect(@uploader.extension_allowlist).not_to include('txt', 'pdf', 'doc')
      end
    end
  end
end
