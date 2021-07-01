require_relative 'my_jwt'
module AUTH
  class User
    attr_accessor :username, :roles

    def initialize(token)
      raise 'Not token provided!' unless token

      decoded = AUTH::Jwt.instance.decode(token)
      @username = decoded["username"]
      @roles =  decoded["roles"]
    end
  end
end
