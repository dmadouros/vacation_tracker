Given(/^I have added several PTO requests$/) do
  create(:pto_request, user: @user, hours: 8, start_date: '01-Mar-2015', end_date: '01-Mar-2015')
  create(:pto_request, user: @user, hours: 8, start_date: '15-Mar-2015', end_date: '15-Mar-2015')
  create(:pto_request, user: @user, hours: 8, start_date: '31-Mar-2015', end_date: '31-Mar-2015')
end

When(/^I visit my dashboard$/) do
  Timecop.freeze('3-Mar-2015')
  application.dashboard_page.open
end

Then(/^I should be asked to create my profile$/) do
  expect(application.create_profile_page.create_profile_page?).to eq true
end

Then(/^I should be shown my dashboard$/) do
  expect(application.dashboard_page.dashboard_page?).to eq true
end

Then(/^I should see my hire date$/) do
  expect(application.dashboard_page.hired_on).to eq '11-Nov-2013'
end

Then(/^I should see my available pto hours$/) do
  expect(application.dashboard_page.pto_hours_available).to eq '148.00'
end

Then(/^I should see my pto requests ordered by start date$/) do
    Timecop.freeze('3-Mar-2015')
    dashboard_page = application.dashboard_page
    dashboard_page.open
    pto_requests = dashboard_page.pto_requests
    first_pto_request = pto_requests.first
    second_pto_request = pto_requests.second
    third_pto_request = pto_requests.last
    expect(first_pto_request.start_date).to eq DateTime.parse('01-Mar-2015')
    expect(second_pto_request.start_date).to eq DateTime.parse('15-Mar-2015')
    expect(third_pto_request.start_date).to eq DateTime.parse('31-Mar-2015')
end
