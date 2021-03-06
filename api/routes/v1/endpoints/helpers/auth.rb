module SecurityHelpers
      def current_user
        user1 = AUTH::User.new(headers['X-Api-Key'])
        @current_user ||= user1
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end

      def grant!(*roles)
        authenticate!
        user = DAO::UserRoleDAO.instance.search_user current_user.username
        if user
          roles_user = user.roles.map(&:name)
          error!('401 Unauthorized', 401) unless (roles[0] & roles_user).length.positive?
        end
      end
end