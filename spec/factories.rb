
FactoryGirl.define do

  factory :rating do
    station
    rider
    value 0

    factory :position_rating do
      value 25
    end

    factory :negative_rating do
      value -25
    end

  end

  factory :rider do
    name "Bob Ross"
    email "bross@paintings.net"
    password "password"
  end

  trait :with_rating do
    after :create do |station|
      create :rating, station: station
    end
  end

  factory :station do
    name "Chipotle"
  end

end