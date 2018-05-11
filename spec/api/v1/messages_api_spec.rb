require 'rails_helper'

RSpec.describe 'Messages API', :type => :request do

  context 'GET /api/v1/messages' do
    it 'access denied' do
      get '/api/v1/messages'
      expect(response.status).to eq(401)
    end
  end

end
