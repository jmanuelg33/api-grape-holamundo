# frozen_string_literal: true

require './api/dao/persona_dao'

module Business
  
  class PersonaBusiness
    include Singleton

    def add_or_update(person)
      persona = DAO::PersonaDAO.instance.search(person[:dni])
      if persona
        DAO::PersonaDAO.instance.update(person[:dni], person[:name],
                                        person[:age], person[:status], person[:description])
      else
        DAO::PersonaDAO.instance.add(person[:dni], person[:name],
                                     person[:age], person[:status], person[:description])
      end
    end

    def delete(id)
      DAO::PersonaDAO.instance.delete(id) if get_person(id)
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
