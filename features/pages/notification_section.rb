class NotificationSection < PageObject
  def messages
    driver.all('.alert-box.success').map(&:text)
  end

  def errors
    driver.all('.alert-box.alert').map(&:text)
  end

  def warnings
    driver.all('.alert-box.warning').map(&:text)
  end
end