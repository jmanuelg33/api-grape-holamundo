require 'spec_helper'
require './api/utils/background_job'

describe 'BACKGROUND JOBS' do
  it 'testing 5 jobs from sidekiq any 10 seconds' do
    5.times do |i|
      jid = BackgroundJob.perform_async(10)
      puts "#{i}-#{jid}"
      expect(jid).not_to be_empty
    end
  end
end
