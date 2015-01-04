class DashboardPage < PageObject
  def open
    driver.visit dashboard_path
  end

  def notifications
    driver.all('.alert-box.success').map(&:text)
  end

  def dashboard_page?
    driver.has_css?('h1', text: 'My Dashboard')
  end

  def hired_on
    driver.first('.hired_on').try(:text)
  end

  def pto_hours_available
    driver.first('.pto_hours_available').try(:text)
  end
end