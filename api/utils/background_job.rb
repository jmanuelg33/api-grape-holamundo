require 'sidekiq'
require 'dotenv'
Dotenv.overload

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://:#{ENV.fetch('REDIS_PASS')}@localhost:6379" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://:#{ENV.fetch('REDIS_PASS')}@localhost:6379" }
end

# worker sidekiq
class BackgroundJob
  include Sidekiq::Worker

  def perform(delay)
    sleep delay
    puts 'waaaaaaaaaaaaaaaahoooooo!'
  end
end
