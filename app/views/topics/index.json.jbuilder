json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :category, :hits, :created_at, :updated_at
  json.author topic.user.name
  json.comments topic.comments.size
end
