require 'sequel'
require './api/tasks/service_config'

module Models
  class Role < Sequel::Model(ServiceConfig[:database])
    unrestrict_primary_key

    many_to_many :users, join_table: :users_roles

    def before_destroy
      users.each do |u|
        remove_user(u)
      end
    end
  end
end
