class PtoRequestCollection

  attr_reader :pto_requests

  def initialize(pto_requests)
    @pto_requests = pto_requests.map do |pto_request|
      PtoRequestPresenter.new(pto_request)
    end
  end

  def empty?
    pto_requests.empty?
  end

  def any_floating_holiday_hours?
    floating_holiday_pto_requests.present?
  end

  def total_pto_hours
    total_hours(pto_requests.reject(&:floating_holiday?))
  end

  def total_floating_holiday_hours
    total_hours(floating_holiday_pto_requests)
  end

  private

  def total_hours(pto_requests)
    pto_requests.map(&:hours).reduce(:+) || 0
  end

  def floating_holiday_pto_requests
    pto_requests.select(&:floating_holiday?)
  end
end