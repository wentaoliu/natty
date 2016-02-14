require 'rails_helper'
include LoginSupport

describe V1::OrdersAPI do

  context 'GET /api/v1/orders' do
    it 'returns an empty array of orders' do
      get '/api/v1/orders', :access_token => access_token
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq []
    end
  end

end
