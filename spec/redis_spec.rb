require 'spec_helper'
require './api/business/persona'
require 'json'
require './api/config/service_config'

describe 'REDIS' do
  redis = ServiceConfig[:redis]

  it 'set to redis first object persona from db' do
    persons = Business::PersonaBusiness.instance.all
    unless persons.empty?
      r = redis.set('first_person', persons[0].to_json)
      expect(r).to eq('OK')
    end
  end

  it 'get to redis first object persona stored in key first_person' do
    r = redis.get('first_person')
    expect(r).to be_truthy
    expect(redis.del('first_person')).to be_truthy
  end
end
