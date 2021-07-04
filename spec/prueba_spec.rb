require 'spec_helper'
require './api/root'

describe MyApp::Root do
  include Rack::Test::Methods

  def app
    MyApp::Root
  end

  context 'CRUD persona' do
    it 'list' do
      get '/api/v1/persona'
      body = JSON.parse(last_response.body)

      expect(last_response.status).to eq(200)
      expect(body.length).not_to eq(0)
    end

    it 'create a person' do
      post '/api/v1/persona/create', { 'persona': {
        'name': 'juanmatest',
        'age': 33,
        'dni': '88031630361',
        'status': 'single',
        'description': ''
      } }, as: :json
      expect(last_response.status).to eq(201)
    end

    it 'update a person' do
      put '/api/v1/persona/update', { 'persona': {
        'name': 'juanmatest2',
        'dni': '88031630361'
      } }, as: :json
      expect(last_response.status).to eq(200)
    end

    it 'delete a person' do
      get '/api/v1/persona/search', { 'dni': '88031630361' }, as: :json
      id = JSON.parse(last_response.body)['id']
      expect(last_response.status).to eq(200)

      delete '/api/v1/persona', { 'id': id }, as: :json
      expect(last_response.status).to eq(200)
    end
  end
end
