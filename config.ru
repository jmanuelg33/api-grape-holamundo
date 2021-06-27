require 'rack'
require_relative 'api/api'
require 'rake'

# load 'Rakefile'
# puts 'Running migrations'
# Rake::Task['db:migrate'].invoke
# puts 'Running seeds'
# Rake::Task['db:seed'].invoke

run MyApp::API
