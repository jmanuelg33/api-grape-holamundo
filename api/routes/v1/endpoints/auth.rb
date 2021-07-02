require './api/auth/authentication'
module Routes
  module V1
    module Endpoints
      #  Persona
      class Auth < Grape::API
        resource :auth do
          # resource begin

          # fn LOGIN
          desc 'login'
          params do
            requires :username, type: String, documentation: { param_type: 'query' } # documentation.. for swagger
            requires :password, type: String, documentation: { param_type: 'query' }
          end
          post :login do
            AUTH::Authentication.instance.login(params[:username], params[:password])
          end

          # fn prueba
          desc 'prueba' do
            headers x_api_key: {    #for documentation swagger
              description: 'Validates your identity',
              required: true
            }
          end
          post :test do
            grant!(['admin','user'])
            'acceso otorgado'
          end

          # resource end
        end
      end
    end
  end
end
