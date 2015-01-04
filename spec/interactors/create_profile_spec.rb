require 'rails_helper'

describe CreateProfile do
  describe '#call' do
    let(:user) { User.create!(email: 'test@example.com', password: 'password') }
    let(:interactor) { CreateProfile.new(current_user: user, profile_params: profile_params) }
    let(:context) { interactor.context }

    context 'when given valid profile params' do
      let(:profile_params) do
        {
          hired_on: '11-Nov-2013',
          pto_hours_used: '72'
        }
      end

      it 'should succeed' do
        interactor.call

        expect(context).to be_a_success
      end

      it 'should create a profile' do
        expect do
          interactor.call
        end.to change(Profile, :count).by(1)
      end

      it 'should set the profile parameters' do
        interactor.call

        profile = Profile.last
        expect(profile.hired_on).to eq DateTime.parse('11-Nov-2013')
        expect(profile.pto_hours_used).to eq 72
      end

      it 'should assign the profile to the user' do
        interactor.call

        expect(user.reload.profile).to eq Profile.last
      end
    end

    context 'when given invalid profile params' do
      let(:profile_params) do
        {
          hired_on: '11-Nov-2013',
          pto_hours_used: '999'
        }
      end

      it 'should fail' do
        expect do
          interactor.call
        end.to raise_error(Interactor::Failure)
      end

      it 'should not create a profile' do
        expect do
          begin
            interactor.call
          rescue
          end
        end.to_not change(Profile, :count)
      end

      it 'should not assign the profile to the user' do
        begin
          interactor.call
        rescue
        end

        expect(user.reload.profile).to be_nil
      end

      it 'should set the profile in the error' do
        begin
          interactor.call
        rescue Interactor::Failure => e
          expect(e.context.profile).to_not be_nil
          expect(e.context.profile.errors).to_not be_empty
        end
      end
    end
  end
end