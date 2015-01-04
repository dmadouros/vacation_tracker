require 'rails_helper'

describe PtoCalculator do

  let(:hired_on) { DateTime.parse('2013-11-11') }
  let(:employee) { User.new(profile: Profile.new(hired_on: hired_on)) }
  subject { PtoCalculator.instance(employee) }

  describe '#available_hours' do

    it 'should be 6.67 after the first month of employement' do
      Timecop.freeze(DateTime.parse('2013-12-01')) do
        expect(subject.available_hours).to be_within(0.01).of(6.67)
      end
    end
  end
end