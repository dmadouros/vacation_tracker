Then(/^I should be shown a success message$/) do
  expect(application.notification_section.messages).to_not be_empty
end

Then(/^I should be shown an error message$/) do
  expect(application.notification_section.errors).to_not be_empty
end

Then(/^I should be shown a warning message$/) do
  expect(application.notification_section.warnings).to_not be_empty
end