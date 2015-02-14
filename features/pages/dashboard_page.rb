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

  def pto_requests
    pto_request_rows = driver.all('.pto_request')
    pto_request_rows.map do |pto_request_row|
      build_pto_request(pto_request_row)
    end
  end

  private

  def build_pto_request(pto_request_row)
    fields = pto_request_row.all('td')
    PtoRequestRow.new(
      pto_request_row,
      start_date: DateTime.parse(fields[0].text),
      end_date: DateTime.parse(fields[1].text),
      hours: Float(fields[2].text),
      status: fields[3].text
    )
  end
end