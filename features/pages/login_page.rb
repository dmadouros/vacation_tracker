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

  def errors
    driver.all('.alert-box.alert').map(&:text)
  end

  def login_page?
    driver.has_css?('h2', text: 'Log in')
  end
end