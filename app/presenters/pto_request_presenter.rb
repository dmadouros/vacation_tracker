class PtoRequestPresenter < SimpleDelegator
  def initialize(pto_request)
    super(pto_request)
    @pto_request = pto_request
  end

  def pto_type
    pto_request.floating_holiday? ? 'Floating Holiday' : 'PTO'
  end

  private

  attr_reader :pto_request
end