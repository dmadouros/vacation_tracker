When(/^I create a profile$/) do
  create_profile_page = application.create_profile_page
  create_profile_page.open
  create_profile_page.hired_on = '11-Nov-2013'
  create_profile_page.pto_hours_used = 72
  create_profile_page.create_profile
end

When(/^I try to create a profile$/) do
  create_profile_page = application.create_profile_page
  create_profile_page.open
end

Given(/^I have a profile$/) do
  email = 'test_user@example.com'
  password = 'password'
  profile = create(:profile, hired_on: '11-Nov-2013', pto_hours_used: 72)
  @user = create(:user, email: email, password: password, profile: profile)
end

When(/^I edit a profile$/) do
  edit_profile_page = application.edit_profile_page
  edit_profile_page.open @user.profile.id
  edit_profile_page.hired_on = '11-Nov-2013'
  edit_profile_page.pto_hours_used = 72
  edit_profile_page.update_profile
end

When(/^I try to edit a profile$/) do
  edit_profile_page = application.edit_profile_page
  edit_profile_page.open @user.profile.id
end

When(/^I edit a profile with invalid data$/) do
  edit_profile_page = application.edit_profile_page
  edit_profile_page.open @user.profile.id
  edit_profile_page.pto_hours_used = 999
  edit_profile_page.update_profile
end