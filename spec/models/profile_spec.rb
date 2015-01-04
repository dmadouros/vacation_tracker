require 'rails_helper'

RSpec.describe Profile, :type => :model do

  let(:profile) { build(:profile, pto_hours_used: 120) }
  subject { profile }

  it { should be_valid }

  describe 'hired_on' do
    it 'should be invalid if hired_on not present' do
      profile.hired_on = nil

      expect(profile.valid?).to be_falsey
      expect(profile.errors[:hired_on]).to_not be_empty
    end

    it 'should be invalid if hired_on is not a date' do
      profile.hired_on = 'abcd'

      expect(profile.valid?).to be_falsey
      expect(profile.errors[:hired_on]).to_not be_empty
    end

    it 'should be invalid if hired_on is not a valid date' do
      profile.hired_on = '30-Feb-2013'

      expect(profile.valid?).to be_falsey
      expect(profile.errors[:hired_on]).to_not be_empty
    end

    it 'should be invalid if hired_on is after today' do
      Timecop.freeze(DateTime.parse('11-Nov-2013')) do
        profile.hired_on = '12-Nov-2013'

        expect(profile.valid?).to be_falsey
        expect(profile.errors[:hired_on]).to_not be_empty
      end
    end
  end

  describe 'pto_hours_used' do
    it 'should be invalid when not an integer' do
      profile.pto_hours_used = 10.72

      expect(profile.valid?).to be_falsey
      expect(profile.errors[:pto_hours_used]).to_not be_empty
    end

    it 'should be invalid when not a number' do
      profile.pto_hours_used = 'abcd'

      expect(profile.valid?).to be_falsey
      expect(profile.errors[:pto_hours_used]).to_not be_empty
    end

    it 'should be invalid when more than 120' do
      profile.pto_hours_used = 121

      expect(profile.valid?).to be_falsey
      expect(profile.errors[:pto_hours_used]).to_not be_empty
    end

    it 'should be invalid when less than 0' do
      profile.pto_hours_used = -1

      expect(profile.valid?).to be_falsey
      expect(profile.errors[:pto_hours_used]).to_not be_empty
    end

    it 'should be valid when equal to 0' do
      profile.pto_hours_used = 0

      expect(profile.valid?).to be_truthy
    end
  end
end