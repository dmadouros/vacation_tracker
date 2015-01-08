Then(/^I should be shown a save error message$/) do
  expect(application.form_error_section.errors).to_not be_empty
end
