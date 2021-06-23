require "sequel"
require "./api/models/address"
require "faker"
require "facets/random"

Sequel.seed(:development, :production, :test) do # Applies only to "development" and "test" environments
  def run
    provinces = {
      "granma" => ["Cauto cristo", "Bayamo", "jiguani"],
      "holguin" => ["rafael freire", "cacocum"],
      "tunas" => ["tuna 1", "tuna 2"],
      "la habana" => ["10 de octubre", "Boyeros"],
      "cienfuegos" => ["cienfuegos 1", "ciefuegos 2"]
    }
    5.times do
      Models::Address.create do |p|
        p.province = provinces.rand_key
        p.town = provinces[p.province][Faker::Number.between(from: 0, to: provinces[p.province].length)]
        p.address = Faker::Address.full_address
      end
    end
    Models::Address.count
  end
end