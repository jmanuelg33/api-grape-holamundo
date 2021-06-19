# frozen_string_literal: true

require 'dry-container'
require 'dry-auto_inject'
require './api/utils/config'
require 'sequel'

require 'dotenv'
Dotenv.overload

# Configuration container.
class ServiceConfig
  extend Dry::Container::Mixin

  register :configuration, memoize: true do
    Config.load_config
  end

  register :database, memoize: true do
    configuration = ServiceConfig[:configuration]

    Sequel.connect(adapter: 'postgres',
                   host: configuration['DB_HOST'],
                   database: configuration['DB_DATABASE'],
                   user: configuration['DB_USER'],
                   password: configuration['DB_PASSWORD'])
  end
end

ConfigContainer = Dry::AutoInject(ServiceConfig)
