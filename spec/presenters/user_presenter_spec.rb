require 'rails_helper'

describe UserPresenter do
  describe '#pto_requests' do
    it 'should wrap pto_requests in PtoRequestPresenters' do
      pto_requests = [build(:pto_request)]
      user = build(:user, pto_requests: pto_requests)

      results = described_class.new(user).pto_requests
      expect(results.first).to be_an_instance_of(PtoRequestPresenter)
    end
  end

  describe 'delegation' do
    it 'should delegate to user' do
      user = build(:user, email: 'hi@there.com')

      expect(described_class.new(user).email).to eq 'hi@there.com'
    end
  end
end