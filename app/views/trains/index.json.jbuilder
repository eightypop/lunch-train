json.array!(@trains) do |train|
  json.extract! train, :id, :depart_time, :riders
  json.recommended train.recommended_stations.take(3).map(&:slug)
end
