require 'grape'
require_relative 'routes/v1/routes'

module MyApp
  class API < Grape::API
    format :json
    prefix :api
    version :v1
    content_type :json, 'application/json'

    mount Routes::V1::API
  end
end
