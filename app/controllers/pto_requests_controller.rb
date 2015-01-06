class PtoRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pto_request = PtoRequest.new

    render :new
  end

  def create
    result = CreatePtoRequest.call(current_user: current_user, pto_request_params: pto_request_params)

    if result.success?
      flash[:notice] = 'PTO Request created successfully.'
      redirect_to dashboard_url
    else
      @pto_request = result.pto_request
      render :new
    end
  end

  private

  def pto_request_params
    params.require(:pto_request).permit(:start_date, :end_date, :hours)
  end
end
