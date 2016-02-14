require 'rails_helper'
include LoginSupport

describe V1::SchedulesAPI do

  context 'GET /api/v1/schedules' do
    it 'returns an empty array of schedules' do
      get '/api/v1/schedules', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
