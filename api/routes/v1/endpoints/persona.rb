require './api/business/persona'
module Routes
  module V1
    module Endpoints
      #  Persona
      class Persona < Grape::API
        resource :persona do
          # resource begin

          # fn index
          desc 'testing calls'
          get do
            Business::PersonaBusiness.instance.all
          end

          # fn search
          desc 'search object person'
          params do
            requires :dni, type: String
          end

          get :search do
            person = Business::PersonaBusiness.instance.find(params[:dni])
            return person.to_hash unless person.nil?

            'No data!'
          end

          # fn create Persona
          desc 'create a person'
          params do
            requires :persona, type: Hash do
              requires :name, type: String, allow_blank: false
              requires :age, type: Integer, allow_blank: false
              requires :dni, type: String, allow_blank: false
              requires :status, type: String, values: %w[single maried]
              requires :description, type: String
            end
          end

          post :create do
            persona = Business::PersonaBusiness.instance.add_or_update(params[:persona])

            return persona.to_hash if persona

            'nothing happend!'
          end

          # fn update Persona
          desc 'update a person'
          params do
            requires :persona, type: Hash do
              optional :name, type: String
              optional :age, type: Integer
              requires :dni, type: String, allow_blank: false
              optional :status, type: Symbol,
                                values: {
                                  value: %i[single maried],
                                  message: 'must be a single or maried status!'
                                }
            end
          end

          put :update do
            persona = Business::PersonaBusiness.instance.add_or_update(params[:persona])

            return persona.to_hash if persona

            'nothing happend!'
          end

          # fn delete a Persona
          desc 'delete a person'
          params do
            requires :id, type: Integer, allow_blank: false
          end

          delete do
            return { status: 'ok', data: 'deleted' } if Business::PersonaBusiness.instance.delete(params[:id])

            'nothing happend!'
          end

          # resource end
        end
      end
    end
  end
end
