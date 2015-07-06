json.array!(@errors) do |error|
  json.extract! error, :id, :type, :timestamp, :message
  json.url error_url(error, format: :json)
end
