Given(/^I have an account$/) do
  email = 'test_user@example.com'
  password = 'password'
  @user = create(:user, email: email, password: password, profile: nil)
end

Given(/^I am not logged in$/) do; end

Given(/^I have logged in before$/) do
  profile = create(:profile, hired_on: '11/11/2013', pto_hours_used: 72)
  @user.profile = profile
  @user.save!
end

Given(/^I have never logged in before$/) do
  @user.profile.destroy if @user.profile.present?
end

Given(/^I am logged in$/) do
  application.login_page.open
  application.login_with_credentials(email: 'test_user@example.com', password: 'password')
end

When(/^I login$/) do
  application.login_page.open
  application.login_with_credentials(email: 'test_user@example.com', password: 'password')
end

Then(/^I should be asked for my authentication credentials$/) do
  expect(application.login_page.login_page?).to eq true
end