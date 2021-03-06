require './api/models/persona'

module DAO
  class PersonaDAO
    include Singleton

    def add(dni, name, age, status, description)
      # si el dni existe no deberia guardarlo, no crea un nuevo registro lo que hace es un update
      model.create(
        dni: dni,
        name: name,
        age: age,
        status: status,
        description: description
      )
    end

    def update(dni, name, age, status, description)
      person = model.first(dni: dni)
      person.update(
        dni: dni,
        name: name || person.name,
        age: age || person.age,
        status: status || person.status,
        description: description || person.description
      )
    end

    def delete(id)
      model.where(id: id).delete
    end

    def search(dni)
      model.find(dni: dni)
    end

    def findById(id)
      model.find(id: id)
    end

    def all
      model.all
    end

    private

    def model
      Models::Persona
    end
  end
end
