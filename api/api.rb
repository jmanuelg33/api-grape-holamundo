require 'grape'
require_relative 'routes/v1/routes'

module MyApp
  class API < Grape::API
    format :json
    prefix :api
    version :v1
    content_type :json, 'application/json'

    # rescue_from :all

    helpers do
      def logger
        API.logger
        # how to use=> logger.info "#{persona.name} as created"  if persona
      end
    end

    mount Routes::V1::API
  end
end
