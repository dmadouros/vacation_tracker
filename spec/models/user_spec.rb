require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:profile) { Profile.new }
  subject { User.new(profile: profile) }

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

  describe '#months_employed' do
    before do
      hired_on = '11/11/2013'
      subject.profile.hired_on = hired_on
    end

    it 'should be 0 when hired_on is the same month/year as current date' do
      Timecop.freeze(DateTime.parse('2013-11-30')) do
        expect(subject.months_employed).to eq 0
      end
    end

    it 'should be 12 when hired_on is same month as hired_on but 1 year later' do
      Timecop.freeze(DateTime.parse('2014-11-30')) do
        expect(subject.months_employed).to eq 12
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
end
