class LoginPage < PageObject
  def open
    driver.visit new_user_session_path
  end

  def email=(email)
    driver.fill_in 'Email', with: email
  end

  def password=(password)
    driver.fill_in 'Password', with: password
  end

  def login
    driver.click_button 'Log in'
  end

  def has_log_in_button?
    driver.has_button?('Log in')
  end

  def errors
    driver.all('.alert-box.alert').map(&:text)
  end
end