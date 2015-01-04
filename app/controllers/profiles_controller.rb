class ProfilesController < ApplicationController

  def new
    if current_user.has_profile?
      flash[:warning] = "A profile already exists for #{current_user.email}."
      redirect_to dashboard_url
    else
      @profile = Profile.new(pto_hours_used: 0)
      render :new
    end
  end

  def create
    result = CreateProfile.call(current_user: current_user, profile_params: profile_params)

    if result.success?
      flash[:notice] = 'Profile created successfully.'
      redirect_to dashboard_url
    else
      @profile = result.profile
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:hired_on, :pto_hours_used)
  end
end
