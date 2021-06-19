# frozen_string_literal: true

require './api/dao/persona_dao'

module Business
  # TrackingInfo class
  class PersonaBusiness
    include Singleton

    def add_or_update(dni, name, age, status,description)
      persona = DAO::PersonaDAO.instance.search(dni)
      if persona
        DAO::PersonaDAO.instance.update(dni, name, age, status,description)
      else
        DAO::PersonaDAO.instance.add(dni, name, age, status,description)
      end
    end

    def delete(id)
      if self.get_person(id)
        DAO::PersonaDAO.instance.delete(id)
      end
    end

    def find(dni)
      DAO::PersonaDAO.instance.search(dni)
    end

    def get_person(id)
      DAO::PersonaDAO.instance.findById(id)
    end

    def all
      DAO::PersonaDAO.instance.all.map(&:to_hash)
    end
  end
end
