json.extract! @topic, :id, :title, :content, :category, :hits, :created_at, :updated_at
json.author @topic.user.name
json.tags do
  json.array! @topic.tags
end
json.comments do
  json.array!(@topic.comments) do |comment|
    json.extract! comment, :id, :content, :created_at
    json.author comment.user.name
  end
end
