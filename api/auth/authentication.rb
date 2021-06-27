require './api/dao/user_role_dao'
require_relative 'my_jwt'

module AUTH
  class Authentication
    include Singleton

    def login(username, password)
      user = DAO::UserRoleDAO.instance.search_user username

      if user && user.password_eql?(password)
        token = AUTH::Jwt.instance.encode(
          {
            username: user.username,
            roles: user.roles
          }
        )
      else
        false
      end
    end
  end
end
