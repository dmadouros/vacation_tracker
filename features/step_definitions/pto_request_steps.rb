Given(/^I have added a PTO request$/) do
  create(:pto_request, user: @user)
end

When(/^I create a PTO request for 8 hours$/) do
  create_pto_request_page = application.create_pto_request_page
  create_pto_request_page.open
  create_pto_request_page.start_date = DateTime.parse('01-Mar-2014')
  create_pto_request_page.end_date = DateTime.parse('01-Mar-2014')
  create_pto_request_page.hours = 8
  create_pto_request_page.create_pto_request
end

When(/^I try to create a pto request$/) do
  application.create_pto_request_page.open
end

When(/^I remove that PTO request$/) do
  dashboard_page = application.dashboard_page
  dashboard_page.open
  pto_requests = dashboard_page.pto_requests
  pto_request = pto_requests.first

  pto_request.destroy_pto_request()
end

Then(/^I should see the PTO request in my list$/) do
  Timecop.freeze('3-Mar-2014')
  dashboard_page = application.dashboard_page
  dashboard_page.open
  pto_requests = dashboard_page.pto_requests
  pto_request = pto_requests.first

  expect(pto_request.start_date).to eq DateTime.parse('01-Mar-2014')
  expect(pto_request.end_date).to eq DateTime.parse('01-Mar-2014')
  expect(pto_request.hours).to eq 8
  expect(pto_request.status).to eq 'Completed'
end

Then(/^I should not see that PTO request in my list$/) do
  dashboard_page = application.dashboard_page
  expect(dashboard_page.pto_requests).to be_empty
end