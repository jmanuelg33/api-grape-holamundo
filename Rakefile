# frozen_string_literal: true

require 'sequel'
require './api/tasks/service_config'

namespace :db do
  desc 'Perform migration up to latest migration available'
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.run(ServiceConfig[:database], 'api/database/migrations')
  end

  desc 'run seeds'
  task :seed do
    Sequel.extension :seed
    Sequel::Seed.setup(:development)
    Sequel::Seeder.apply(ServiceConfig[:database], './api/database/seeds')
  end
end
