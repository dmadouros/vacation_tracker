require 'rails_helper'

describe PtoRequestPresenter do
  describe '#pto_type' do
    context 'when PTO request' do
      it 'should be "PTO"' do
        pto_request = build(:pto_request, floating_holiday: false)

        expect(described_class.new(pto_request).pto_type).to eq 'PTO'
      end
    end

    context 'when floating holiday request' do
      it 'should be "Floating Holiday"' do
        pto_request = build(:pto_request, floating_holiday: true)

        expect(described_class.new(pto_request).pto_type).to eq 'Floating Holiday'
      end
    end
  end

  describe 'delegation' do
    it 'should delegate to pto_request' do
      pto_request = build(:pto_request, hours: 8)

      expect(described_class.new(pto_request).hours).to eq 8
    end
  end
end
