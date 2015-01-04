require 'rails_helper'

RSpec.describe User, :type => :model do

  describe '#has_profile?' do
    it 'should be true when the user has a profile' do
      user = User.new
      profile = Profile.new
      user.profile = profile

      expect(user).to have_profile
    end

    it 'should be false when the user has no profile' do
      user = User.new

      expect(user).to_not have_profile
    end
  end
end
