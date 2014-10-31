require 'rails_helper'

RSpec.describe Station, :type => :model do

  context 'with a rider' do
    let(:rider) { create :rider, id: 1 }

    context 'with ratings' do
      let(:cava) { create(:station, name: 'Cava') }
      let!(:rating1) { create(:rating, rider: rider, station: cava, value: 43)}
      let!(:rating2) { create(:rating, rider: rider, station: create(:station, name: 'Chipotle')) }
      let!(:rating3) { create(:rating, rider: rider, station: create(:station, name: 'McDonalds')) }
      it 'can get stations' do
        rider_ratings = Station.with_rider_ratings(rider)
        expect(rider_ratings).to_not be_empty
        expect(rider_ratings).to include(an_object_having_attributes(name: 'Cava'))
        expect(rider_ratings).to include(an_object_having_attributes(name: 'Chipotle'))
        expect(rider_ratings).to include(an_object_having_attributes(name: 'McDonalds'))
      end

      it 'can get ratings' do
        rider_cava = Station.with_rider_ratings(rider).where(name: 'Cava').first
        expect(rider_cava.rating).to eq(43)
        expect(rider_cava.rider_id).to eq(1)

      end

      context 'when another has ratings too' do
        let(:another) { create :rider, email: 'someone@else.net', name: 'Jimbob Hoobastank', id: 2 }
        let!(:another_rating) { create(:rating, rider: another, station: cava, value: 50) }

        it 'can get ratings' do
          rider_cava = Station.with_rider_ratings(rider).where(name: 'Cava').first
          expect(rider_cava.rating).to eq(43)
          expect(rider_cava.rider_id).to eq(1)
          another_cava = Station.with_rider_ratings(another).where(name: 'Cava').first
          expect(another_cava.rating).to eq(50)
          expect(another_cava.rider_id).to eq(2)
        end

      end
    end

    context 'without ratings' do
      let!(:station1) { create :station, name: 'Cava' }
      let!(:station2) { create :station, name: 'Chipotle' }
      let!(:station3) { create :station, name: 'McDonalds' }
      it 'can get stations' do
        rider_ratings = Station.with_rider_ratings(rider)
        expect(rider_ratings).to_not be_empty
        expect(rider_ratings).to include (an_object_having_attributes(name: 'Cava'))
        expect(rider_ratings).to include (an_object_having_attributes(name: 'Chipotle'))
        expect(rider_ratings).to include (an_object_having_attributes(name: 'McDonalds'))
      end
    end


  end


end
