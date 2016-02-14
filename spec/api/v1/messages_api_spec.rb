require 'rails_helper'
include LoginSupport

describe V1::MessagesAPI do

  context 'GET /api/v1/messages' do
    it 'returns an empty array of messages' do
      get '/api/v1/messages', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
