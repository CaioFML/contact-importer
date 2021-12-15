Sidekiq.configure_server do |config|
  config.options[:concurrency] = Integer(ENV["SIDEKIQ_THREADS"] || 5)
  config.redis = { db: 1 }

  Rails.logger = Sidekiq.logger
end

Sidekiq.configure_client do |config|
  config.redis = { size: Integer(ENV["RAILS_MAX_THREADS"] || 5), db: 1 }
end
