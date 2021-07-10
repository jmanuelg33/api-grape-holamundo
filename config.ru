require 'rack'
require_relative 'api/root'
require 'rake'

# load 'Rakefile'
# puts 'Running migrations'
# Rake::Task['db:migrate'].invoke
# puts 'Running seeds'
# Rake::Task['db:seed'].invoke

#sidekiqs begin
require 'sidekiq'
require 'sidekiq/web'
require 'dotenv'
Dotenv.overload

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://:#{ENV.fetch('REDIS_PASS')}@localhost:6379" }
end

use Rack::Session::Cookie, secret: SecureRandom.hex(32), same_site: true, max_age: 86400   #=> needed only by Sidekiq

#sidekiqs end

use Rack::Static, :urls => ["/public"]
run Rack::URLMap.new('/' => MyApp::Root, '/sidekiq' => Sidekiq::Web) # => needed for runs multiples apps!
# run MyApp::Root   =>a clasic way
