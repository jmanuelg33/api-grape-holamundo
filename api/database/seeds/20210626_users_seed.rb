require 'sequel'
require './api/models/user'
require 'faker'

Sequel.seed(:development, :production, :test) do # Applies only to "development" and "test" environments
  def run
    Models::User.create do |p|
      p.name = "juanma"
      p.username = "jmanuelg33"
      p.password = "jmanuelg33"
    end
  end
end
