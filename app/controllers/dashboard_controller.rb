class DashboardController < ApplicationController
  def show
    if current_user.has_profile?
      render :show
    else
      redirect_to new_profile_url
    end
  end
end
