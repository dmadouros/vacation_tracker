require 'rails_helper'

describe EditProfile do

  describe '#call' do
    let(:profile) { create(:profile, hired_on: '11-Apr-2013', pto_hours_used: 106)}
    let(:user) { create(:user, profile: profile) }
    let(:interactor) { EditProfile.new(current_user: user, profile_params: profile_params) }
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

      it 'should set the profile parameters' do
        interactor.call

        profile.reload
        expect(profile.hired_on).to eq DateTime.parse('11-Nov-2013')
        expect(profile.pto_hours_used).to eq 72
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

      it 'should not update the profile' do
        begin
          interactor.call
        rescue
        end

        profile.reload
        expect(profile.hired_on).to eq DateTime.parse('11-Apr-2013')
        expect(profile.pto_hours_used).to eq 106
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