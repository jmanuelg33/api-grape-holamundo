require 'sequel'
require './api/config/service_config'

module Models
  class Address < Sequel::Model(ServiceConfig[:database][:addresses])
    unrestrict_primary_key
   
    many_to_one :persona, key: :persona_id
  end
end
