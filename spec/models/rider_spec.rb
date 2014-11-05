require 'rails_helper'

describe Rider do
  subject(:rider) { create :rider }

  context "with a station" do
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

  context "with a train" do
    let(:train){ create :train }

    context "when on the train" do
      it 'returns true for #is_on?' do
        train.riders << subject

        expect(subject.is_on?(train)).to be_truthy
      end
    end

    context "when not on the train" do
      it 'returns false for #is_on?' do
        expect(subject.is_on?(train)).to be_falsy
      end
    end
  end
end
