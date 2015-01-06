class CreatePtoRequestPage < PageObject

  def open
    driver.visit new_pto_request_path
  end

  def start_date=(start_date)
    driver.fill_in 'Start Date', with: start_date.to_s(:concise)
  end

  def end_date=(end_date)
    driver.fill_in 'End Date', with: end_date.to_s(:concise)
  end

  def hours=(hours)
    driver.fill_in 'Hours', with: hours
  end

  def create_pto_request
    driver.click_on 'Create'
  end
end