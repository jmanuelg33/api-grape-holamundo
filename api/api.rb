require 'grape'
require_relative 'routes/v1/routes'
require './api/auth/authentication'
require './api/auth/user'
require './api/dao/user_role_dao'

module MyApp
  class API < Grape::API
    format :json
    prefix :api
    version :v1
    content_type :json, 'application/json'

    # rescue_from :all do |e|
    #   Rack::Response.new([e.message], 500, 'Content-type' => 'text/error')
    # end

    helpers do
      def logger
        API.logger
      end

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
          roles_user = user.roles.map { |i| i.name }
          error!('401 Unauthorized', 401) unless (roles[0] & roles_user).length.positive?
        end
      end
    end

    mount Routes::V1::API
  end
end
