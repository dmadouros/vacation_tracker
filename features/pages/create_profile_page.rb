class CreateProfilePage < PageObject
  def open
    driver.visit new_profile_path
  end

  def notifications
    driver.all('.alert-box.success').map(&:text)
  end

  def create_profile_page?
    driver.has_content? 'Create Profile'
  end

  def hired_on=(hired_on)
    driver.fill_in 'Hired On', with: hired_on
  end

  def pto_hours_used=(pto_hours_used)
    driver.fill_in 'PTO Hours Used', with: pto_hours_used
  end

  def create_profile
    driver.click_on 'Create'
  end
end