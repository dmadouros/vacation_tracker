When(/^I visit my dashboard$/) do
  application.dashboard_page.open
end

Then(/^I should be asked to create my profile$/) do
  expect(application.create_profile_page.create_profile_page?).to eq true
end

Then(/^I should be shown my dashboard$/) do
  expect(application.dashboard_page.dashboard_page?).to eq true
end

Then(/^I should see my hire date$/) do
  expect(application.dashboard_page.hired_on).to eq "11-Nov-2013"
end

Then(/^I should see my available pto hours$/) do
  expect(application.dashboard_page.pto_hours_available).to eq "100.00"
end