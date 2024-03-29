# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = ENV.fetch('AWS_BUCKET', nil)
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil),
      region: 'ap-northeast-1',
      path_style: true
    }
  end
end
