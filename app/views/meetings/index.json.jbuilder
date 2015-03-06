json.items do
  json.array!(@news) do |item|
    json.extract! item, :id, :title, :content, :updated_at
  end
end
json.pager do
  json.count @count
  json.offset @offset
  json.per_page @per_page
end
