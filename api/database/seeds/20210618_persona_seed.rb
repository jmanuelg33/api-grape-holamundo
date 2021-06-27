require 'sequel'
require './api/models/persona'
require 'faker'

Sequel.seed(:development, :production, :test) do # Applies only to "development" and "test" environments
  def run
    marital_status = { 0 => 'single', 1 => 'maried' }
    status = Faker::Number.between(from: 0, to: 1)
    dnis =  %w[88011430361 88011430362 88011430363 88011430364 88011430365]

    5.times do |i|
      Models::Persona.create do |p|
        p.name = Faker::Name.name
        p.dni = dnis[i]
        p.age = Faker::Number.between(from: 1, to: 99)
        p.status = marital_status[status]
        p.description = Faker::Lorem.sentence(word_count: 5)
      end
    end
    Models::Persona.count
  end
end
