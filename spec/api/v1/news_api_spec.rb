require 'rails_helper'
include LoginSupport

describe V1::NewsAPI do

  context 'GET /api/v1/news' do
    it 'returns an empty array of news' do
      get '/api/v1/news', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
