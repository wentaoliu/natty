require 'rails_helper'
include LoginSupport

describe V1::AchievementsAPI do

  context 'GET /api/v1/achievements' do
    it 'returns an empty array of achievements' do
      get '/api/v1/achievements', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
