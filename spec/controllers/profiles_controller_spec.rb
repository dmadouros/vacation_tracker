require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do
  let(:user) { create(:user, profile: nil) }

  before { sign_in user }

  it_should_behave_like 'an authenticating controller' do
    let(:controller_action) { :new }
    before { sign_out user }
  end

  describe '#new' do

    context 'when user does not have a profile' do
      it 'should render the new page' do
        get :new

        expect(response).to render_template(:new)
      end

      it 'should assign a new profile' do
        get :new

        expect(assigns(:profile)).to be_a(Profile)
        expect(assigns(:profile).persisted?).to eq false
      end
    end

    context 'when user does have a profile' do
      let(:profile) { create(:profile) }

      before do
        user.profile = profile
        user.save!
      end

      it 'should redirect to the dashboard page' do
        get :new

        expect(response).to redirect_to dashboard_url
      end

      it 'should set a warning message' do
        get :new

        expect(flash[:warning]).to eq 'A profile already exists for test@example.com.'
      end
    end
  end

  describe '#create' do

    let(:user) { User.create!(email: 'test@example.com', password: 'password') }
    let(:params) do
      params = {
        profile: {
          'hired_on' => '11-Nov-2013',
          'pto_hours_used' => '72'
        }
      }
    end

    before do
      sign_in user
      expect(CreateProfile).to receive(:call).once.with(current_user: user, profile_params: params[:profile]).and_return(context)
    end

    context 'when successful' do
      let(:context) { double(:context, success?: true) }

      it 'should redirect to the dashboard page' do
        post :create, params

        expect(response).to redirect_to dashboard_url
      end

      it 'should set a success message' do
        post :create, params

        expect(flash[:notice]).to eq 'Profile created successfully.'
      end
    end

    context 'when not successful' do
      let(:profile) { Profile.new }
      let(:context) { double(:context, success?: false, profile: profile) }

      it 'should assign the profile' do
        post :create, params

        profile = assigns(:profile)
        expect(assigns(:profile)).to eq profile
      end

      it 'should render the new page' do
        post :create, params

        expect(response).to render_template(:new)
      end
    end
  end
end
