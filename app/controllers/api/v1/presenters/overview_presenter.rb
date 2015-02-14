module API
  module V1
    module Presenters
      class OverviewPresenter

        def initialize(user)
          @user = user
        end

        def call
          {
            email: user.email,
            hired_on: user.hired_on.to_s(:concise),
            pto_hours_used: format('%.2f', user.pto_hours_used),
            pto_hours_accrued: format('%.2f', user.pto_hours_accrued),
            pto_hours_available: format('%.2f', user.pto_hours_available),
            as_of: DateTime.current.to_s(:concise)
          }
        end

        private

        attr_reader :user
      end
    end
  end
end