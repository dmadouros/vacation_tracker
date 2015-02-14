module API
  module V1
    module Presenters
      class PtoRequestPresenter

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
          }
        end

        private

        attr_reader :pto_request
      end
    end
  end
end