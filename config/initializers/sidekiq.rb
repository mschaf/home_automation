redis_url = if Rails.env.production?
    'redis://redis:6379/0'
  else
    'redis://localhost:6379/0'
  end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url}
end