class Train < ActiveRecord::Base

  belongs_to :station
  has_and_belongs_to_many :riders

  def recommended_stations
      ActiveSupport::OrderedHash[ranked_stations.sort_by { |k,v| v }.reverse].map do |s, v|
        s.score = v
        s
      end
  end

  protected
  def ranked_stations
    ratings = riders.inject([]) do |all, rider|
      all.push(*rider.ratings)
    end

    scores = {}

    Station.all.each do |s|
      scores[s] = ratings.inject(0) do |score, rating|
        score += rating.value if s == rating.station
        score
      end
    end
    scores
  end

end
