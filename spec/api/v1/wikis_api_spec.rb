require 'rails_helper'
include LoginSupport

describe V1::WikisAPI do

  context 'GET /api/v1/wikis' do
    it 'returns an empty array of wikis' do
      get '/api/v1/wikis', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
