require 'rails_helper'

describe EditPtoRequest do

  describe '#call' do
    let(:user) { create(:user) }
    let(:pto_request) { create(:pto_request, user: user) }
    let(:interactor) { EditPtoRequest.new(current_user: user, pto_request_id: pto_request.id, pto_request_params: pto_request_params) }
    let(:context) { interactor.context }

    context 'when given valid pto_request params' do
      let(:pto_request_params) do
        {
          start_date: '11-Dec-2013',
          end_date: '12-Dec-2013',
          hours: '7'
        }
      end

      it 'should succeed' do
        interactor.call

        expect(context).to be_a_success
      end

      it 'should set the pto_request parameters' do
        interactor.call

        pto_request.reload
        expect(pto_request.start_date).to eq DateTime.parse('11-Dec-2013')
        expect(pto_request.end_date).to eq DateTime.parse('12-Dec-2013')
        expect(pto_request.hours).to eq 7
      end
    end

    context 'when given invalid pto_request params' do
      let(:pto_request_params) do
        {
          start_date: '11-Dec-2013',
          end_date: '12-Dec-2013',
          hours: '999'
        }
      end

      it 'should fail' do
        expect do
          interactor.call
        end.to raise_error(Interactor::Failure)
      end

      it 'should not update the pto_request' do
        begin
          interactor.call
        rescue
        end

        pto_request.reload
        expect(pto_request.start_date).to eq DateTime.parse('01-Mar-2015')
        expect(pto_request.end_date).to eq DateTime.parse('01-Mar-2015')
        expect(pto_request.hours).to eq 8
      end

      it 'should set the pto_request in the error' do
        begin
          interactor.call
        rescue Interactor::Failure => e
          expect(e.context.pto_request).to_not be_nil
          expect(e.context.pto_request.errors).to_not be_empty
        end
      end
    end
  end
end