json.array!(@messages) do |message|
  json.extract! message, :content
end
