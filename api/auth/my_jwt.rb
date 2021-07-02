# frozen_string_literal: true

require 'jwt'
require './api/config/service_config'

module AUTH
  class Jwt
    include Singleton

    def encode(payload)
      payload[:exp] = Time.now.to_i + 4 * 3600
      JWT.encode(payload, secret, 'HS256')
    end

    def decode(token)
      JWT.decode(token, secret, true, {algorithm: 'HS256'})[0]
    end

    private

    def secret
      ServiceConfig[:configuration]['SECRET']
    end
  end
end
