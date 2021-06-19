require_relative 'endpoints/persona'

module Routes
  module V1
    # Entry point class for routes
    class API < Grape::API
      format :json
      content_type :json, 'application/json'
      
      mount V1::Endpoints::Persona
    end
  end
end
