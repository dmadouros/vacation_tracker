require 'rails_helper'

describe PtoRequestCollection do
  let(:pto_requests) do
    user = build(:user)
    [
        build(:pto_request, user: user, hours: 8),
        build(:pto_request, user: user, hours: 10, floating_holiday: true),
        build(:pto_request, user: user, hours: 3),
    ]
  end

  describe '#pto_requests' do
    it 'should return presented pto_requests' do
      expect(described_class.new(pto_requests).pto_requests.first).to be_an_instance_of PtoRequestPresenter
    end

    it 'should order pto_requests by start_date' do
      user = build(:user)
      pto_requests = [
          middle_pto_request = create(:pto_request, user: user, start_date: '15-Mar-2015', end_date: '31-Mar-2015'),
          earliest_pto_request = create(:pto_request, user: user, start_date: '01-Mar-2015', end_date: '31-Mar-2015'),
          latest_pto_request = create(:pto_request, user: user, start_date: '31-Mar-2015', end_date: '31-Mar-2015'),
      ]

      results = described_class.new(pto_requests).pto_requests

      expect(results.first.start_date).to eq earliest_pto_request.start_date
      expect(results.second.start_date).to eq middle_pto_request.start_date
      expect(results.last.start_date).to eq latest_pto_request.start_date
    end
  end

  describe '#empty?' do
    context 'when no pto_requests' do
      it 'should be true' do
        expect(described_class.new([]).empty?).to eq true
      end
    end

    context 'when some pto_requests' do
      it 'should be false' do
        expect(described_class.new(pto_requests).empty?).to eq false
      end
    end
  end

  describe '#any_floating_holiday_hours?' do
    context 'when some floating holiday hours' do
      it 'should be true' do
        expect(described_class.new([build(:pto_request, hours: 8, floating_holiday: true)]).any_floating_holiday_hours?).to eq true
      end
    end

    context 'when no floating holiday hours' do
      it 'should be false' do
        expect(described_class.new([build(:pto_request, hours: 8, floating_holiday: false)]).any_floating_holiday_hours?).to eq false
      end
    end
  end

  describe '#total_pto_hours' do
    it 'should return the total' do
      expect(described_class.new(pto_requests).total_pto_hours).to eq 11
    end
  end

  describe '#total_floating_holiday_hours' do
    it 'should return the total' do
      expect(described_class.new(pto_requests).total_floating_holiday_hours).to eq 10
    end
  end
end