class API < Grape::API

  format :json
  content_type :json, 'application/json;charset=utf-8'

  mount V1::Root

  route :any, '*path' do
    status 404
    { error: 'Page not found.' }
  end
end