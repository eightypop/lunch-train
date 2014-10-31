class Station < ActiveRecord::Base

  has_many :ratings

  scope :with_rider_ratings, ->(rider) {
    joins("left outer join ratings rider_ratings on rider_ratings.station_id = stations.id and rider_ratings.rider_id = #{rider.id}")
      .select('stations.*, rider_ratings.value as rating, rider_ratings.rider_id as rider_id')
  }

end