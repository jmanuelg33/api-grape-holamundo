# frozen_string_literal: true

require_relative 'abstract'
# Creator class for factory strategy.
class FactoryCreator
  def self.create(table_hash)
    case table_hash['type']
    when 'FEDEX'
      Fedex.new(table_hash['tracking_number'])
    when 'prueba2'
      Prueba2.new(table_hash['tracking_number'])
    else
      raise "Tracking strategy not implemented: #{type}"
    end
  end
end
