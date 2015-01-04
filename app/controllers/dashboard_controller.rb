class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.has_profile?
      render :show
    else
      redirect_to new_profile_url
    end
  end
end
