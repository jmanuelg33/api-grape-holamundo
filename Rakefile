# frozen_string_literal: true

require 'sequel'
require './api/config/service_config'

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
  desc "Generate a new migration file `generate_migration[003_create_table_person]`"
  task :generate_migration, [:file_name] do |task, args|
    name = args.file_name
    abort("Missing migration file name") if name.nil?

    content = <<~STR
      # frozen_string_literal: true
      Sequel.migration do
        transaction
      
        up do
          # create_table(:table_name) do
          #   Serial :id, primary_key: true
          #   String   :name, size: 50, null: false
          #   DateTime :created_at, default: Sequel.function(:NOW)
          #   DateTime :updated_at, default: Sequel.function(:NOW)
          # end
        end
      
        down do
          # drop_table(:table_name)
        end
      end      
    STR

    filename = File.join("./api/database/migrations/", "#{name}.rb")
    File.write(filename, content)
    puts "Generated: #{filename}"
  end

  desc "Create a model file `generate_model[Person]`"
  task :generate_model, [:file_name] do |task, args|
    name = args.file_name
    abort("Missing model file name") if name.nil?

    content = <<~STR
      # frozen_string_literal: true
      require 'sequel'
      require './api/config/service_config'

      module Models
        class #{name.capitalize} < Sequel::Model(ServiceConfig[:database])
          unrestrict_primary_key
        end
      end
 
    STR

    filename = File.join("./api/models/", "#{name.downcase}.rb")
    File.write(filename, content)
    puts "Generated: #{filename}"
  end
end
