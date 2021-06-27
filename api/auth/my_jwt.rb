# frozen_string_literal: true

require 'jwt'
require './api/tasks/service_config'

module AUTH
  # Json Web Token Class
  class Jwt
    include Singleton

    def encode(payload, exp = 180)
      payload[:exp] = exp.to_i

      JWT.encode(payload, secret)
    end

    def decode(token)
      JWT.decode(token, secret)[0]
    rescue StandardError => e
      raise e.message
    end

    private

    def secret
      ServiceConfig[:configuration]['JWT_SECRET']
    end
  end
end
