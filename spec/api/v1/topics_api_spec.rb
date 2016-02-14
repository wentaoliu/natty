require 'rails_helper'
include LoginSupport

describe V1::TopicsAPI do

  context 'GET /api/v1/topics' do
    it 'returns an empty array of topics' do
      get '/api/v1/topics', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
