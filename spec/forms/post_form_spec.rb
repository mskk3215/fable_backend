# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostForm, type: :model do
  describe '#save' do
    let(:user) { create(:user) }
    let(:image_file) { Rack::Test::UploadedFile.new(Rails.public_path.join('images/test_image.png'), 'image/png') }

    context '有効な画像が与えられた場合' do
      let(:form) { PostForm.new(current_user: user, collected_insect_images: [image_file]) }

      it '投稿を保存する' do
        expect { form.save }.to change(Post, :count).by(1)
        expect(Post.last.collected_insects.count).to eq 1
        expect(Post.last.collected_insects.first.collected_insect_image).to be_present
      end
    end

    context '無効な画像データが与えられた場合' do
      let(:invalid_image_file) { 'invalid data' }
      let(:form) { PostForm.new(current_user: user, collected_insect_images: [invalid_image_file]) }

      it '投稿を保存せず、エラーメッセージを返す' do
        expect { form.save }.not_to change(Post, :count)
        expect(form.errors.full_messages).to include("Collected insect images can't be blank")
      end
    end
  end
end
