require 'rails_helper'

describe CreatePtoRequest do
  describe '#call' do
    let(:user) { create(:user) }
    let(:interactor) { CreatePtoRequest.new(current_user: user, pto_request_params: pto_request_params) }
    let(:context) { interactor.context }

    context 'when given valid pto_request params' do
      let(:pto_request_params) do
        {
          start_date: '01-Mar-2014',
          end_date: '02-Mar-2014',
          hours: '16',
          floating_holiday: true,
        }
      end

      it 'should succeed' do
        interactor.call

        expect(context).to be_a_success
      end

      it 'should create a PtoRequest' do
        expect do
          interactor.call
        end.to change(PtoRequest, :count).by(1)
      end

      it 'should set the pto_request parameters' do
        interactor.call

        pto_request = PtoRequest.last
        expect(pto_request.start_date).to eq DateTime.parse('01-Mar-2014')
        expect(pto_request.end_date).to eq DateTime.parse('02-Mar-2014')
        expect(pto_request.hours).to eq 16
        expect(pto_request.floating_holiday).to eq true
      end

      it 'should assign the PtoRequest to the User' do
        interactor.call

        expect(user.reload.pto_requests.first).to eq PtoRequest.last
      end
    end

    context 'when given invalid pto_request params' do
      let(:pto_request_params) { {} }

      it 'should fail' do
        expect do
          interactor.call
        end.to raise_error(Interactor::Failure)
      end

      it 'should not create a pto_request' do
        expect do
          begin
            interactor.call
          rescue
          end
        end.to_not change(PtoRequest, :count)
      end

      it 'should not assign the pto_request to the user' do
        begin
          interactor.call
        rescue
        end

        expect(user.reload.pto_requests).to be_empty
      end

      it 'should set the PtoRequest in the error' do
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