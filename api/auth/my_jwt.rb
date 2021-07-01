# frozen_string_literal: true

require 'jwt'
require './api/tasks/service_config'

module AUTH
  class Jwt
    include Singleton

    def encode(payload)
      payload[:exp] = Time.now.to_i + 4 * 3600
      JWT.encode(payload, secret)
    end

    def decode(token)
      JWT.decode(token, secret, false)[0]
    end

    private

    def secret
      ServiceConfig[:configuration]['JWT_SECRET']
    end
  end
end
