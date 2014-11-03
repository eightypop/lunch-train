
FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

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
    email
    password "password"

    factory :rider_with_ratings do
      transient do
        to_rate []

      end

      after(:create) do |rider, evaluator|
        evaluator.to_rate.each do  |station, rating|
          rider.ratings << create(:rating, station: station, value: rating)
        end
      end
    end


  end

  trait :with_rating do

    transient do
      rider (create :rider)

    end

    after :create do |station|
      create :rating, station: station, rider: evaluator.rider
    end
  end

  factory :station do
    name "Chipotle"
  end

  factory :train do
    depart_time Time.parse "September 25 2002 1:02pm EST"
    factory :train_with_riders do

      transient do
        new_riders []
      end

      after(:create) do |train, evaluator|
        train.riders = evaluator.new_riders
      end
    end
  end

end