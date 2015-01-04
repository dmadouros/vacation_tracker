require 'rails_helper'

describe DashboardController, :type => :controller do

  before { sign_in user }

  it_should_behave_like 'an authenticating controller' do
    let(:controller_action) { :show }
    let(:user) { create(:user) }
    before { sign_out user }
  end

  describe '#show' do

    context 'when user has profile' do
      let(:user) { create(:user) }

      before do
        profile = create(:profile)
        user.profile = profile
        user.save!
      end

      it 'should render the show page' do
        get :show

        expect(response).to render_template(:show)
      end
    end

    context 'when user has no profile' do
      let(:user) { create(:user, profile: nil) }

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
