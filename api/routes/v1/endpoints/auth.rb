require './api/auth/authentication'
module Routes
  module V1
    module Endpoints
      #  Persona
      class Auth < Grape::API
        resource :auth do
          # resource begin

          before do
          end

          # fn index
          desc 'login'
          params do
            requires :username, type: String
            requires :password, type: String
          end
          post :login do
            AUTH::Authentication.instance.login(params[:username], params[:password])
          end

          # resource end
        end
      end
    end
  end
end
