require 'sequel'
require './api/tasks/service_config'

module Models
  class User < Sequel::Model(ServiceConfig[:database])
    unrestrict_primary_key

    many_to_many :roles, join_table: :users_roles
    def before_destroy
      roles.each do |r|
        remove_role(r)
      end
    end
  end
end
