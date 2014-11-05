require 'rails_helper'

RSpec.describe Train, :type => :model do



  context 'with riders' do
    let!(:cava) {create :station, name: 'Cava' }
    let!(:chipotle) {create :station, name: 'Chipotle' }
    let!(:fiveguys) { create :station, name: '5Guys' }

    context 'with ratings' do
      let(:train) { create :train, riders: [rider1, rider2, rider3] }
      let(:stations) { { cava => 20, chipotle => 15, fiveguys => 10 } }
      let(:rider1) { create :rider_with_ratings, to_rate: stations }
      let(:rider2) { create :rider_with_ratings, to_rate: stations }
      let(:rider3) { create :rider_with_ratings, to_rate: stations }


      it 'can get stations ordered by riders ratings' do
        recommended_stations = train.recommended_stations
        first_station = recommended_stations.first
        expect(recommended_stations).to_not be_empty
        expect(first_station).to have_attributes(score: 60, name: 'Cava')
        expect(recommended_stations.last).to have_attributes(score: 30, name: '5Guys')
      end
    end

    context 'without ratings' do
      let(:rider1) { create :rider }
      let(:rider2) { create :rider }
      let(:rider3) { create :rider }
      let(:train) { create :train, riders: [rider1, rider2, rider3] }
      it 'can get stations' do

        expect(Rating.all).to be_empty

        recommended_stations = train.recommended_stations

        expect(recommended_stations).to_not be_empty
        expect(recommended_stations.count).to be(3)
        expect(recommended_stations).to include(an_object_having_attributes(name: 'Cava'))
      end
    end

  end



end
