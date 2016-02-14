require 'rails_helper'
include LoginSupport

describe V1::MeetingsAPI do

  context 'GET /api/v1/meetings' do
    it 'returns an empty array of meetings' do
      get '/api/v1/meetings', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
