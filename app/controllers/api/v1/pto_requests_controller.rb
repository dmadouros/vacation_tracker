module API
  module V1
    class PtoRequestsController < ApplicationController
      acts_as_token_authentication_handler_for User, fallback_to_devise: true
      before_action :restrict_access

      def index
        render json: current_user.pto_requests.map(&method(:present_pto_request))
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
