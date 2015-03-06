json.extract! @news, :id, :title, :content, :created_at, :updated_at
json.read_times @news.read_times.to_i
