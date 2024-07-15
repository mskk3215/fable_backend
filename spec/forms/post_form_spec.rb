# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostForm, type: :model do
  describe '#save' do
    let(:user) { create(:user) }
    let(:image_file) { Rack::Test::UploadedFile.new(Rails.public_path.join('images/test_image.png'), 'image/png') }

    context '有効な画像が与えられた場合' do
      let(:form) { PostForm.new(current_user: user, collected_insect_images: [image_file]) }

      it '投稿を保存する' do
        expect { form.save }.to change(Post, :count).by(1).and change(CollectedInsectImage, :count).by(1)
        expect(Post.last.collected_insect_images.count).to eq 1
      end
    end

    context '無効な画像データが与えられた場合' do
      let(:invalid_image_file) { 'invalid data' }
      let(:form) { PostForm.new(current_user: user, collected_insect_images: [invalid_image_file]) }

      it '投稿を保存しない' do
        expect { form.save }.not_to change(Post, :count)
      end
    end
  end
end
