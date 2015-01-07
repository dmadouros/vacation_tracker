class EditProfilePage < PageObject
  def open(id)
    driver.visit edit_profile_path id
  end

  def hired_on=(hired_on)
    driver.fill_in 'Hired On', with: hired_on
  end

  def pto_hours_used=(pto_hours_used)
    driver.fill_in 'PTO Hours Used', with: pto_hours_used
  end

  def update_profile
    driver.click_on 'Save'
  end
end