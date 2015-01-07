class EditProfile
  include Interactor

  def call
    profile.update_attributes(context.profile_params)
    unless profile.save
      context.fail!(profile: profile)
    end
  end

  private

  def profile
    context.current_user.profile
  end
end