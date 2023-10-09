# frozen_string_literal: true

# 画像アップロード用の設定
CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog # fogを使うように設定
    config.fog_provider = 'fog/aws' # fogが使用するストレージサービスを指定
    config.fog_directory = ENV.fetch('AWS_BUCKET_FOR_FABLE', nil) # 作成したS3バケット名を指定
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID_FOR_FABLE', nil),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY_FOR_FABLE', nil),
      region: 'us-east-1',
    } # S3にアクセスするための認証情報
  end
end
