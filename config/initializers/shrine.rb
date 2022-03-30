# frozen_string_literal: true

require 'shrine'
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

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
