require_relative 'endpoints/persona'

module Routes
  module V1
    # Entry point class for routes
    class API < Grape::API
      mount Endpoints::Persona
    end
  end
end
