require './api/models/user'
require './api/models/role'

module DAO
  class UserRoleDAO
    include Singleton
    # roles
    def add_role(name)
      model_role.create(
        name: name
      )
    end

    def update_role(name, new_name)
      role = model_role.first(name: name)
      if role
        role.update(
          name: new_name
        )
      end
    end

    def delete_role(id)
      model_role.where(id: id).destroy
    end

    def search_role(name)
      model_role.find(name: name)
    end

    def all_roles
      model_role.all
    end

    # user
    def add_user(name, username, password)
      model_user.create(
        name: name,
        username: username,
        password: password
      )
    end

    def update_user(name, username, password)
      user = model_user.first(username: username)
      if user
        user.update(
          name: name || user.name,
          password: password || user.password
        )
      end
    end

    def delete_user(id)
      model_user.where(id: id).destroy
    end

    def search_user(username)
      model_user.find(username: username)
    end

    def all_users
      model_user.all
    end

    # add  associations
    def add_user_role(username, roles_name = [])
      user = search_user(username)
      if user
        roles_name.each do |name|
          role = search_role(name)
          user.add_role(role) if role && user
        end
      end
      user
    end

    #  remove associations
    def remove_user_role(username, roles_name = [])
      user = search_user(username)
      if user
        roles_name.each do |name|
          role = search_role(name)
          user.remove_role(role) if role && user
        end
      end
      user
    end

    private

    def model_user
      Models::User
    end

    def model_role
      Models::Role
    end
  end
end
