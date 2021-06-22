require 'sequel'
require './api/tasks/service_config'

module Models

  class Persona < Sequel::Model(ServiceConfig[:database])
    unrestrict_primary_key

    def validate
      super
      errors.add(:dni, 'is not a valid cuban dni!') if chech_dni(dni)
    end

    def chech_dni(dni)
      date = dni[0..6]
      y = date[0..1]
      m = date[2..3]
      d = date [3..4]
      !Date.valid_date? y.to_i, m.to_i, d.to_i
    end
  end

end
