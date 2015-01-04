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
end