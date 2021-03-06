require './api/business/persona'
module Routes
  module V1
    module Endpoints
      #  Persona
      class Persona < Grape::API
        resource :persona do
          # resource begin

          before do
            @output ||= 'v1-'
          end

          # fn index
          desc 'get all personas'
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
              requires :name, type: String, allow_blank: false, documentation: { param_type: 'query' }
              requires :age, type: Integer, allow_blank: false, documentation: { param_type: 'query' }
              requires :dni, type: String, allow_blank: false, documentation: { param_type: 'query' }
              requires :status, type: String, values: %w[single maried], documentation: { param_type: 'query' }
              requires :description, type: String, documentation: { param_type: 'query' }
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
              optional :name, type: String, documentation: { param_type: 'query' }
              optional :age, type: Integer, documentation: { param_type: 'query' }
              requires :dni, type: String, allow_blank: false, documentation: { param_type: 'query' }
              optional :status, type: Symbol,
                                values: {
                                  value: %i[single maried],
                                  message: 'must be a single or maried status!'
                                }, documentation: { param_type: 'query' }
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
            Business::PersonaBusiness.instance.delete(params[:id])
          end

          # resource end
        end
      end
    end
  end
end
