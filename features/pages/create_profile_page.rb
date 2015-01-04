class CreateProfilePage < PageObject
  def open
    driver.visit root_path
  end

  def notifications
    driver.all('.alert-box.success').map(&:text)
  end

  def create_profile_page?
    driver.has_content? 'Create Profile'
  end
end