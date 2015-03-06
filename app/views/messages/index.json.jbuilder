json.array!(@users) do |user|
  json.extract! user, :id, :username, :name
  json.url user_url(user, format: :json)
end
