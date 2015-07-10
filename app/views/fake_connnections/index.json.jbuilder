json.array!(@fake_connnections) do |fake_connnection|
  json.extract! fake_connnection, :id, :name, :state, :sale_count, :refund_count, :scenario
  json.url fake_connnection_url(fake_connnection, format: :json)
end
