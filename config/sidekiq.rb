# frozen_string_literal: true

require 'sidekiq'
require_relative '../app/sidekiq/import_csv_job'

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://myredis:6379/' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://myredis:6379/' }
end
