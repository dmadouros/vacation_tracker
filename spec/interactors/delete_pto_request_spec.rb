require 'rails_helper'

describe DeletePtoRequest do
  describe '#call' do
    let(:user) { create(:user) }
    let(:interactor) { DeletePtoRequest.new(current_user: user, pto_request_id: pto_request.id) }
    let(:context) { interactor.context }
    let!(:pto_request) { create(:pto_request, user: user) }

    context 'when given valid profile params' do
      it 'should succeed' do
        interactor.call

        expect(context).to be_a_success
      end

      it 'should destroy the pto_request' do
        expect do
          interactor.call
        end.to change(PtoRequest, :count).by(-1)
      end

      it 'should assign the PtoRequest to the User' do
        interactor.call

        expect(user.reload.pto_requests).not_to include pto_request
      end
    end
  end
end