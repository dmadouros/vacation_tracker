module API
  module V1
    class OverviewController < ApplicationController
      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      before_action :restrict_access

      def show
        render json: Presenters::OverviewPresenter.new(current_user).call
      end

      private

      def restrict_access
        head :unauthorized unless current_user
      end
    end
  end
end