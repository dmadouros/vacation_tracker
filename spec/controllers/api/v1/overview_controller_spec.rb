require 'rails_helper'

module API
  module V1
    describe OverviewController, :type => :controller do
      let!(:user) { create(:user, email: 'test@example.com', authentication_token: 'xyz123') }
      let(:overview_presenter) { double(:overview_presenter) }

      before do
        request.headers['X-User-Email'] = 'test@example.com'
        request.headers['X-User-Token'] = 'xyz123'

        allow(Presenters::OverviewPresenter).to receive(:new).with(user).and_return(overview_presenter)
      end

      describe '#show' do
        it 'present an overview for a given user' do
          allow(overview_presenter).to receive(:call).and_return(email: user.email)

          xhr :get, :show

          expect(response.code).to eq '200'

          json = JSON.parse(response.body)
          expect(json['email']).to eq 'test@example.com'
        end
      end
    end
  end
end