require 'rails_helper'
include LoginSupport

describe V1::ResourcesAPI do

  context 'GET /api/v1/resources' do
    it 'returns an empty array of resources' do
      get '/api/v1/resources', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
