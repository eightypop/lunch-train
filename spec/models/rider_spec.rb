require 'rails_helper'

describe Rider do

  context "with a station" do
    subject(:rider) { create :rider }
    let(:station) { create :station }
    let(:generic_rating) { create :rating, rider: rider, station: station, value: 26 }

    context "when no rating exists" do
      it 'can get a rating' do
        expect(subject.get_rating_for(station)).to eq(0)
      end

      it 'can set a rating' do
        expect(subject.update_rating(station, 20)).to be_truthy
        expect(subject.get_rating_for(station)).to eq(20)
      end
    end

    it 'can update a rating' do
      value = generic_rating.value
      expect(subject.get_rating_for(station)).to eq(value)
      expect(subject.update_rating(station, 20)).to be_truthy
      expect(subject.get_rating_for(station)).to eq(20)
    end

    it 'can get a rating' do
      value = generic_rating.value
      expect(rider.get_rating_for(station)).to eq(value)
    end

  end

end