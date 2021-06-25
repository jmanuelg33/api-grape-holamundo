require 'sequel'
require './api/models/role'
require 'faker'

Sequel.seed(:development, :production, :test) do # Applies only to "development" and "test" environments
  def run
    roles = %w[admin editor user]
    roles.length.times do |i|
      Models::Role.create do |p|
        p.name = roles[i]
      end
    end
  end
end
