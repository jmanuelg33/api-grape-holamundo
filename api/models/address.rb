require 'sequel'
require './api/tasks/service_config'
require_relative 'persona'

module Models
  class Address < Sequel::Model(ServiceConfig[:database][:adresses])
    unrestrict_primary_key
    many_to_one :persona, key: :id
  end
end
