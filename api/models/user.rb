require 'sequel'
require './api/config/service_config'
require 'bcrypt'

module Models
  class User < Sequel::Model(ServiceConfig[:database])
    unrestrict_primary_key

    many_to_many :roles, join_table: :users_roles

    def before_destroy
      roles.each do |r|
        remove_role(r)
      end
    end

    def password_eql?(password_to)
      BCrypt::Password.new(password) == password_to
    end

    def password=(new_password)
      password = BCrypt::Password.create(new_password)
      super(password)
    end
  end
end
