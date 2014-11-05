class Rider < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :ratings
  has_and_belongs_to_many :trains

  def get_rating_for(station)
    (rating = station_rating(station)) ? rating.value : 0
  end

  def update_rating(station, rating_value)
    rating = (station_rating(station) or ratings.build(station: station))

    rating.value = rating_value
    rating.save
  end

  def is_on? train
    trains.include? train
  end

  private
  def station_rating(station)
    ratings.where(station: station).first
  end

end
