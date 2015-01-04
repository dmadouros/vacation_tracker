class CreateProfile
  include Interactor

  def call
    current_user.profile = Profile.new(context.profile_params)
    unless current_user.save
      context.fail!(profile: current_user.profile)
    end
  end

  private

  def current_user
    context.current_user
  end
end