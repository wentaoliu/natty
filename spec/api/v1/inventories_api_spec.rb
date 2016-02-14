require 'rails_helper'
include LoginSupport

describe V1::InventoriesAPI do

  context 'GET /api/v1/inventories' do
    it 'returns an empty array of inventories' do
      get '/api/v1/inventories', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
