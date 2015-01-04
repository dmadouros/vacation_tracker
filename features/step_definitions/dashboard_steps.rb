Then(/^I should be asked to create my profile$/) do
  expect(application.create_profile_page.create_profile_page?).to eq true
end

Then(/^I should be shown my dashboard$/) do
  expect(application.dashboard_page.dashboard_page?).to eq true
end