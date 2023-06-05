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
  end
end
