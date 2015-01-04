require 'rails_helper'

describe DashboardController, :type => :controller do

  let(:user) { User.create!(email: 'test@example.com', password: 'password') }

  before do
    sign_in user
  end

  describe '#show' do

    context 'when user has profile' do
      before do
        profile = Profile.create!(hired_on: "11/11/2014")
        user.profile = profile
        user.save!
      end

      it 'should render the show page' do
        get :show

        expect(response).to render_template(:show)
      end
    end

    context 'when user has no profile' do
      before do
        expect(user.profile).to_not be_present
      end

      it 'should redirect to the create profile page' do
        get :show

        expect(response).to redirect_to new_profile_path
      end
    end
  end
end
