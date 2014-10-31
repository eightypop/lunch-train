class Rating < ActiveRecord::Base
  belongs_to :station
  belongs_to :rider

  validates :value, presence: true, on: :create
  validates :value, numericality: { greater_than_or_equal_to: -50, less_than_or_equal_to: 50 }


end
