json.items do
  json.array!(@news) do |item|
    json.extract! item, :id, :title, :content, :updated_at
  end
end
json.pager do
  json.current_page params[:page] || 1
  json.pages @pages
end
