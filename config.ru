require 'rack'
require_relative 'api/root'
require 'rake'

# load 'Rakefile'
# puts 'Running migrations'
# Rake::Task['db:migrate'].invoke
# puts 'Running seeds'
# Rake::Task['db:seed'].invoke

use Rack::Static, :urls => ["/public"]
run MyApp::Root