require 'rails_helper'

module API
  module V1
    describe PtoRequestsController, :type => :controller do
      let!(:user) { create(:user, email: 'test@example.com', authentication_token: 'xyz123') }
      let!(:pto_request) { create(:pto_request, user: user) }
      let(:pto_request_presenter) { double(:pto_request_presenter) }

      before do
        request.headers['X-User-Email'] = 'test@example.com'
        request.headers['X-User-Token'] = 'xyz123'

        allow(Presenters::PtoRequestPresenter).to receive(:new).with(pto_request).and_return(pto_request_presenter)
      end

      describe '#index' do
        it 'present pto_requests for a given user' do
          allow(pto_request_presenter).to receive(:call).and_return(foo: 'bar')

          xhr :get, :index

          expect(response.code).to eq '200'

          json = JSON.parse(response.body)
          expect(json.size).to eq 1
          expect(json[0]['foo']).to eq 'bar'
        end
      end
    end
  end
end