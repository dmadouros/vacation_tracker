require 'rails_helper'

RSpec.describe PtoRequest, :type => :model do
  let(:profile) { create(:profile, hired_on: '11-Nov-2013') }
  let(:user) { create(:user, profile: profile) }
  let(:pto_request) { build(:pto_request, user: user, start_date: '12-Nov-2013', end_date: '12-Nov-2013', hours: 8) }
  subject { pto_request }

  it { should be_valid }

  describe '#start_date' do
    it 'should be invalid if start_date not present' do
      pto_request.start_date = nil

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:start_date]).to_not be_empty
    end

    it 'should be invalid if start_date is not a date' do
      pto_request.start_date = 'abcd'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:start_date]).to_not be_empty
    end

    it 'should be invalid if start_date is not a valid date' do
      pto_request.start_date = '30-Feb-2013'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:start_date]).to_not be_empty
    end

    it 'should be invalid if start_date is on hire date' do
      pto_request.start_date = '11-Nov-2013'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:start_date]).to_not be_empty
    end

    it 'should be invalid if start_date is before hire date' do
      pto_request.start_date = '10-Nov-2013'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:start_date]).to_not be_empty
    end

    it 'should be invalid if end_date before start_date' do
      pto_request.start_date = '11-Nov-2013'
      pto_request.end_date = '10-Nov-2013'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:start_date]).to_not be_empty
    end

    it 'should be valid if end_date is same as start_date' do
      pto_request.start_date = '12-Nov-2013'
      pto_request.end_date = '12-Nov-2013'

      expect(pto_request.valid?).to be_truthy
    end

    it 'should be valid start_date when start_date is valid even if end date is invalid' do
      pto_request.start_date = '12-Nov-2013'
      pto_request.end_date = ''

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:start_date]).to be_empty
    end
  end

  describe '#end_date' do
    it 'should be invalid if end_date not present' do
      pto_request.end_date = nil

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:end_date]).to_not be_empty
    end

    it 'should be invalid if end_date is not a date' do
      pto_request.end_date = 'abcd'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:end_date]).to_not be_empty
    end

    it 'should be invalid if end_date is not a valid date' do
      pto_request.end_date = '30-Feb-2014'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:end_date]).to_not be_empty
    end

    it 'should be invalid if end_date on hire date' do
      profile = create(:profile, hired_on: DateTime.parse('11-Nov-2013'))
      user = create(:user, profile: profile)
      pto_request = build(:pto_request, user: user)

      pto_request.end_date = '11-Nov-2013'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:end_date]).to_not be_empty
    end

    it 'should be invalid if end_date before hire date' do
      profile = create(:profile, hired_on: DateTime.parse('11-Nov-2013'))
      user = create(:user, profile: profile)
      pto_request = build(:pto_request, user: user)

      pto_request.end_date = '10-Nov-2013'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:end_date]).to_not be_empty
    end

    it 'should be invalid if end_date is not in same month as start_date' do
      pto_request = build(:pto_request, start_date: '31-Jan-2015')

      pto_request.end_date = '01-Feb-2015'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:end_date]).to include 'must be in the same month'
    end
  end

  describe '#hours' do
    it 'should be valid when a float' do
      pto_request.hours = 10.72

      expect(pto_request.valid?).to be_truthy
      expect(pto_request.errors[:hours]).to be_empty
    end

    it 'should be invalid when not a number' do
      pto_request.hours = 'abcd'

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:hours]).to_not be_empty
    end

    it 'should be invalid when more than 120' do
      pto_request.hours = 121

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:hours]).to_not be_empty
    end

    it 'should be invalid when less than 0' do
      pto_request.hours = -1

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:hours]).to_not be_empty
    end

    it 'should be invalid when equal to 0' do
      pto_request.hours = 0

      expect(pto_request.valid?).to be_falsey
      expect(pto_request.errors[:hours]).to_not be_empty
    end
  end

  describe '#status' do
    context 'when today is before start_date' do
      it 'should be "Pending"' do
        pto_request = build(:pto_request, start_date: '06-Jan-2015', end_date: '06-Jan-2015')
        Timecop.freeze('05-Jan-2015') do
          expect(pto_request.status).to eq 'Pending'
        end
      end
    end

    context 'when today is after end_date' do
      it 'should be "Completed"' do
        pto_request = build(:pto_request, start_date: '03-Jan-2015', end_date: '04-Jan-2015')
        Timecop.freeze('05-Jan-2015') do
          expect(pto_request.status).to eq 'Completed'
        end
      end
    end

    context 'when today is end_date' do
      it 'should be "In Progress"' do
        pto_request = build(:pto_request, start_date: '03-Jan-2015', end_date: '04-Jan-2015')
        Timecop.freeze('04-Jan-2015') do
          expect(pto_request.status).to eq 'In Progress'
        end
      end
    end

    context 'when today is start_date' do
      it 'should be "In Progress"' do
        pto_request = build(:pto_request, start_date: '05-Jan-2015', end_date: '06-Jan-2015')
        Timecop.freeze('05-Jan-2015') do
          expect(pto_request.status).to eq 'In Progress'
        end
      end
    end

    context 'when today is after start_date and before end_date' do
      it 'should be "In Progress"' do
        pto_request = build(:pto_request, start_date: '04-Jan-2015', end_date: '06-Jan-2015')
        Timecop.freeze('05-Jan-2015') do
          expect(pto_request.status).to eq 'In Progress'
        end
      end
    end
  end

  describe '#pto_type' do
    context 'when PTO request' do
      it 'should be "PTO"' do
        pto_request = build(:pto_request, floating_holiday: false)

        pto_request.pto_type.should == 'PTO'
      end
    end

    context 'when floating holiday request' do
      it 'should be "Floating Holiday"' do
        pto_request = build(:pto_request, floating_holiday: true)

        pto_request.pto_type.should == 'Floating Holiday'
      end
    end
  end
end