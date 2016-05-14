module API
  module V1
    class PtoRequestsController < ApplicationController
      acts_as_token_authentication_handler_for User, fallback_to_devise: true
      before_action :restrict_access

      def index
        pto_requests = current_user.pto_requests.sort do |a, b|
          result = a.start_date <=> b.start_date
          result = result * -1 if current_user.pto_request_sort_direction == 'desc'
          result
        end

        render json: pto_requests.map(&method(:present_pto_request))
      end

      def destroy
        PtoRequest.find(params[:id]).destroy

        head :no_content
      end

      private

      def restrict_access
        head :unauthorized unless current_user
      end

      def present_pto_request(pto_request)
        Presenters::PtoRequestPresenter.new(pto_request).call
      end
    end
  end
end
