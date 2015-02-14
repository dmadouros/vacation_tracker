require 'rails_helper'

module API
  module V1
    module Presenters
      describe OverviewPresenter do
        let(:user) { double(:user) }

        subject { OverviewPresenter.new(user) }

        before do
          allow(user).to receive(:email).and_return('test@example.com')
          allow(user).to receive(:hired_on).and_return(DateTime.parse('01-Mar-2014'))
          allow(user).to receive(:pto_hours_used).and_return(72.0)
          allow(user).to receive(:pto_hours_accrued).and_return(28.0)
          allow(user).to receive(:pto_hours_available).and_return(148.0)
        end

        describe '#call' do
          it 'should present the email for a given user' do
            result = subject.call

            expect(result[:email]).to eq 'test@example.com'
          end

          it 'should present the hired_on date for a given user' do
            result = subject.call

            expect(result[:hired_on]).to eq '01-Mar-2014'
          end

          it 'should present the pto_hours_used for a given user' do
            result = subject.call

            expect(result[:pto_hours_used]).to eq '72.00'
          end

          it 'should present the pto_hours_accrued for a given user' do
            result = subject.call

            expect(result[:pto_hours_accrued]).to eq '28.00'
          end

          it 'should present the pto_hours_available for a given user' do
            result = subject.call

            expect(result[:pto_hours_available]).to eq '148.00'
          end

          it 'should present the as_of date' do
            Timecop.freeze(DateTime.parse('13-Feb-2015')) do
              result = subject.call

              expect(result[:as_of]).to eq '13-Feb-2015'
            end
          end
        end
      end
    end
  end
end