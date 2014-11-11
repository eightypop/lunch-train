class Train < ActiveRecord::Base

  validates :depart_time, presence: true

  belongs_to :station
  has_and_belongs_to_many :riders

  scope :today, -> { where('depart_time >= ?',  Time.zone.now.beginning_of_day ) }

  def recommended_stations
    ranked_stations.sort_by{ |rs| rs.score }.reverse
  end

  private
  def ranked_stations
    station_ratings = riders.map(&:ratings).flatten.group_by(&:station_id)

    Station.all.map do | station |
      station.score = station_rank(station_ratings, station)

      station
    end
  end

  def station_rank(station_ratings, station)
    return 0 if station_ratings[station.id].nil?

    station_ratings[station.id].reduce(0) do | sum, rating |
      sum + rating.value
    end
  end

end
