class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.has_profile?
      flash[:warning] = "A profile already exists for #{current_user.email}."
      redirect_to dashboard_url
    else
      @profile = Profile.new(hired_on: Date.today, pto_hours_used: 0)
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

  def edit
    @profile = current_user.profile
  end

  def update
    result = EditProfile.call(current_user: current_user, profile_params: profile_params)

    if result.success?
      flash[:notice] = 'Profile updated successfully.'
      redirect_to dashboard_url
    else
      @profile = result.profile
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:hired_on, :pto_hours_used)
  end
end
