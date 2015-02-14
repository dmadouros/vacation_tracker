module API
  module V1
    class SessionsController < ApplicationController

      def create
        user = User.find_by(email: params[:email])
        unless user
          head :not_found
          return
        end

        if user.valid_password?(params[:password])
          render json: {auth_token: user.authentication_token}
        else
          head :not_found
        end
      end
    end
  end
end