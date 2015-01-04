require 'rails_helper'

describe PtoCalculator do

  let(:hired_on) { DateTime.parse('2013-11-11') }
  let(:profile) { build(:profile, hired_on: hired_on, pto_hours_used: 0)}
  let(:employee) { build(:user, profile: profile) }
  subject { PtoCalculator.instance(employee) }

  describe '#accrued_hours' do

    it 'should be 6.67 after the first month of employement' do
      Timecop.freeze(DateTime.parse('2013-12-01')) do
        expect(subject.accrued_hours).to be_within(0.01).of(6.67)
      end
    end
  end

  describe '#available_hours' do

    it 'should be 13.33 by the end of the year' do
      Timecop.freeze(DateTime.parse('2013-12-01')) do
        expect(subject.available_hours).to be_within(0.01).of(13.33)
      end
    end
  end
end