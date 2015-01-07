Then(/^I should be shown a save error message$/) do
  expect(application.error_notification_section.errors).to_not be_empty
end
