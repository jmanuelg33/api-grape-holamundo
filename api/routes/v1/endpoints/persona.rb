module Routes
  module V1
    module Endpoints
      #  Persona
      class Persona < Grape::API
        get '/persona' do
          'from persona grettings!'
        end
      end
    end
  end
end
