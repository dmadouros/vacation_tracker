require 'rails_helper'

describe PtoRequestsController, :type => :controller do
  let(:user) { create(:user, profile: nil) }

  before { sign_in user }

  it_should_behave_like 'an authenticating controller' do
    let(:controller_action) { :new }
    before { sign_out user }
  end

  describe '#new' do
    it 'should render the new page' do
      get :new

      expect(response).to render_template(:new)
    end

    it 'should assign a new pto_request' do
      get :new

      expect(assigns(:pto_request)).to be_a(PtoRequest)
      expect(assigns(:pto_request).persisted?).to eq false
    end
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:params) do
      params = {
        pto_request: {
          'start_date' => '01-Mar-2014',
          'end_date' => '01-Mar-2014',
          'hours' => '8'
        }
      }
    end

    before do
      sign_in user
      expect(CreatePtoRequest).to receive(:call).once.with(current_user: user, pto_request_params: params[:pto_request]).and_return(context)
    end

    context 'when successful' do
      let(:context) { double(:context, success?: true) }

      it 'should redirect to the dashboard page' do
        post :create, params

        expect(response).to redirect_to dashboard_url
      end

      it 'should set a success message' do
        post :create, params

        expect(flash[:notice]).to eq 'PTO Request created successfully.'
      end
    end

    context 'when not successful' do
      let(:pto_request) { build(:pto_request, user: user) }
      let(:context) { double(:context, success?: false, pto_request: pto_request) }

      it 'should assign the pto_request' do
        post :create, params

        expect(assigns(:pto_request)).to eq pto_request
      end

      it 'should render the new page' do
        post :create, params

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#destroy' do
    let!(:pto_request) { create(:pto_request, user: user) }
    let(:context) { double(:context, success?: true) }

    before do
      sign_in user
      expect(DeletePtoRequest).to receive(:call).once.with(current_user: user, pto_request_id: pto_request.id.to_s).and_return(context)
    end

    it 'should redirect to the dashboard page' do
      delete :destroy, id: pto_request.id.to_s

      expect(response).to redirect_to dashboard_url
    end

    it 'should set a success message' do
      delete :destroy, id: pto_request.id.to_s

      expect(flash[:notice]).to eq 'PTO Request deleted successfully.'
    end
  end
end
