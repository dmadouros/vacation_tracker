class EditProfile
  include Interactor

  def call
    unless profile.update_attributes(context.profile_params)
      context.fail!(profile: profile)
    end
  end

  private

  def profile
    context.current_user.profile
  end
end