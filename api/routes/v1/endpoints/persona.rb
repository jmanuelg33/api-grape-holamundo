module Routes
  module V1
    module Endpoints
      #  Persona
      class Persona < Grape::API
        desc 'testing calls'
        params do
          requires :name, type: String
        end
        get '/persona' do
          "from persona grettings! #{params[:name]}"
        end
      end
    end
  end
end
