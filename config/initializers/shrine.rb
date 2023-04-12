# frozen_string_literal: true

require 'shrine'

if Rails.env.production?
  require 'shrine/storage/s3'

  secrets = Rails.application.credentials[:aws]

  s3_options = {
    bucket: secrets[:s3_bucket],
    region: secrets[:region],
    access_key_id: secrets[:access_key_id],
    secret_access_key: secrets[:secret_access_key]
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(public: true, **s3_options)
  }
end

if Rails.env.development?
  require 'shrine/storage/file_system'

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')
  }
end

if Rails.env.test?
  require 'shrine/storage/memory'

  p "aaa"

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
