require 'grape'
require 'rack/cors'
require 'grape-swagger'
require_relative 'routes/v1/routes'

module MyApp
  class Root < Grape::API
    format :json
    prefix :api
    version :v1
    content_type :json, 'application/json'

    use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post put delete options]
      end
    end

    rescue_from :all do |e|
      Rack::Response.new([e.message], 500, 'Content-type' => 'text/error')
    end

    helpers do
      def logger
        API.logger
      end
    end

    # helpers otherHelpers

    mount Routes::V1::API
    # http://localhost:9292/api/v1/swagger_doc
    add_swagger_documentation(:api_version => "api/v1")
  end
end
