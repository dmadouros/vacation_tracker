require 'rails_helper'

module API
  module V1
    module Presenters
      describe PtoRequestPresenter do
        let(:pto_request) { double(:pto_request) }

        subject { PtoRequestPresenter.new(pto_request) }

        before do
          allow(pto_request).to receive(:id).and_return('42')
          allow(pto_request).to receive(:start_date).and_return(DateTime.parse('01-Mar-2014'))
          allow(pto_request).to receive(:end_date).and_return(DateTime.parse('15-Mar-2014'))
          allow(pto_request).to receive(:hours).and_return(28)
          allow(pto_request).to receive(:status).and_return('Pending')
        end

        describe '#call' do
          it 'should present the id for a given user' do
            result = subject.call

            expect(result[:id]).to eq '42'
          end

          it 'should present the start_date date for a given user' do
            result = subject.call

            expect(result[:start_date]).to eq '01-Mar-2014'
          end

          it 'should present the end_date for a given user' do
            result = subject.call

            expect(result[:end_date]).to eq '15-Mar-2014'
          end

          it 'should present the hours for a given user' do
            result = subject.call

            expect(result[:hours]).to eq 28
          end

          it 'should present the status for a given user' do
            result = subject.call

            expect(result[:status]).to eq 'Pending'
          end
        end
      end
    end
  end
end