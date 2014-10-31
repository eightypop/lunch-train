json.array!(@stations) do |station|
  json.extract! station, :id, :name, :rating
  json.url station_url(station, format: :json)
end
