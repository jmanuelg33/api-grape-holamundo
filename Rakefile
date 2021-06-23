# frozen_string_literal: true

require 'sequel'
require './api/tasks/service_config'

namespace :db do
  desc 'Perform migration up to latest migration available'
  task :migrate, [:version] do |_t, args|
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel::Migrator.run(ServiceConfig[:database], 'api/database/migrations', target: version)
  end

  desc 'run seeds'
  task :seed do
    Sequel.extension :seed
    Sequel::Seed.setup(:development)
    Sequel::Seeder.apply(ServiceConfig[:database], './api/database/seeds')
  end
end
