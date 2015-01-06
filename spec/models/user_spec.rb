require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:profile) { build(:profile) }
  subject { create(:user, profile: profile) }

  describe '#has_profile?' do
    it 'should be true when the user has a profile' do
      expect(subject).to have_profile
    end

    it 'should be false when the user has no profile' do
      subject.profile = nil

      expect(subject).to_not have_profile
    end
  end

  describe '#hired_on' do
    it 'should be the hired_on date from the profile if profile present' do
      hired_on = '11/11/2013'
      subject.profile.hired_on = hired_on

      expect(subject.hired_on).to eq hired_on
    end
  end

  describe '#months_employed_on' do
    before do
      hired_on = '11/11/2013'
      subject.profile.hired_on = hired_on
    end

    it 'should be 0 when hired_on is the same month/year as current date' do
      Timecop.freeze(DateTime.parse('2013-11-30')) do
        expect(subject.months_employed_on(Dates.current_date)).to eq 0
      end
    end

    it 'should be 12 when hired_on is same month as hired_on but 1 year later' do
      Timecop.freeze(DateTime.parse('2014-11-30')) do
        expect(subject.months_employed_on(Dates.current_date)).to eq 12
      end
    end
  end

  describe '#first_year?' do
    before do
      hired_on = '11/11/2013'
      subject.profile.hired_on = hired_on
    end

    it 'should be true when current date is within first year of hire' do
      Timecop.freeze(DateTime.parse('2013-11-30')) do
        expect(subject.first_year?).to eq true
      end
    end
  end

  describe '#pto_requests' do
    let!(:pto_request) { create(:pto_request, user: subject) }

    it 'should return a collection of pto requests' do
      expect(subject.pto_requests).to include pto_request
    end
  end

  describe '#pto_hours_requested' do
    before do
      create(:pto_request, hours: 8, user: subject)
      create(:pto_request, hours: 16, user: subject)
    end

    it 'should be the sum of the hours of all pto requests' do
      expect(subject.pto_hours_requested).to eq 24
    end
  end
end
