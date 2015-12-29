Given(/^I have added a PTO request$/) do
  create(:pto_request, user: @user, hours: 8, start_date: '01-Mar-2015', end_date: '01-Mar-2015')
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

When(/^I edit that PTO request$/) do
  dashboard_page = application.dashboard_page
  dashboard_page.open
  pto_requests = dashboard_page.pto_requests
  pto_request = pto_requests.first
  pto_request.edit_pto_request

  edit_pto_request_page = application.edit_pto_request_page
  edit_pto_request_page.hours = 6
  edit_pto_request_page.start_date = DateTime.parse('06-Apr-2015')
  edit_pto_request_page.end_date = DateTime.parse('07-Apr-2015')
  edit_pto_request_page.update_pto_request
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
  expect(pto_request.pto_type).to eq 'PTO'
end

Then(/^I should not see that PTO request in my list$/) do
  dashboard_page = application.dashboard_page
  expect(dashboard_page.pto_requests).to be_empty
end

Then(/^I should see the updates to that PTO request in my list$/) do
  dashboard_page = application.dashboard_page
  dashboard_page.open
  pto_requests = dashboard_page.pto_requests
  pto_request = pto_requests.first

  expect(pto_request.hours).to eq 6
  expect(pto_request.start_date).to eq '06-Apr-2015'
  expect(pto_request.end_date).to eq '07-Apr-2015'
end