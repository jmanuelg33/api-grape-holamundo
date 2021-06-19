require 'sequel'
require './api/tasks/service_config'

module Models

  class Persona < Sequel::Model(ServiceConfig[:database][:persona])
    unrestrict_primary_key
  end

end
