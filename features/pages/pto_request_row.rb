class PtoRequestRow < PageObject
  attr_reader :start_date, :end_date, :hours, :status, :pto_type

  def after_initialize(options)
    @start_date = options.fetch(:start_date)
    @end_date = options.fetch(:end_date)
    @hours = options.fetch(:hours)
    @status = options.fetch(:status)
    @pto_type = options.fetch(:pto_type)
  end

  def edit_pto_request
    driver.click_on 'Edit'
  end

  def destroy_pto_request
    driver.click_on 'Delete'
  end
end