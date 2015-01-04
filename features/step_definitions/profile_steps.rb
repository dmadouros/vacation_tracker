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