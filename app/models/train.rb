class Train < ActiveRecord::Base

  belongs_to :station
  has_and_belongs_to_many :riders

  def recommended_stations
    []

  end

end
