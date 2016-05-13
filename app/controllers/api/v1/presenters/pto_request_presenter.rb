module API
  module V1
    module Presenters
      class PtoRequestPresenter
        include Rails.application.routes.url_helpers

        def initialize(pto_request)
          @pto_request = pto_request
        end

        def call
          {
            id: pto_request.id,
            start_date: pto_request.start_date.to_s(:concise),
            end_date: pto_request.end_date.to_s(:concise),
            hours: pto_request.hours,
            status: pto_request.status,
            pto_type: pto_type,
            edit_link: edit_pto_request_path(pto_request),
            delete_link: pto_request_path(pto_request),
          }
        end

        private

        attr_reader :pto_request

        def pto_type
          pto_request.floating_holiday? ? 'Floating Holiday' : 'PTO'
        end
      end
    end
  end
end
