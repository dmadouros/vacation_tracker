class PtoRequestRow < PageObject
  attr_reader :start_date, :end_date, :hours, :status

  def after_initialize(options)
    @start_date = options.fetch(:start_date)
    @end_date = options.fetch(:end_date)
    @hours = options.fetch(:hours)
    @status = options.fetch(:status)
  end

  def destroy_pto_request
    driver.click_on 'Delete'
  end
end