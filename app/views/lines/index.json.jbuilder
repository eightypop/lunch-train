json.array!(@lines) do |line|
  json.extract! line, :id, :name, :time_zone
  json.url line_url(line, format: :json)
end
