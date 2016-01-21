json.array!(@inventories) do |inventory|
  json.extract! inventory, :id
  json.url inventory_url(inventory, format: :json)
end
