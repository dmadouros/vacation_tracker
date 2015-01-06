Given(/^my I was hired on (.*)$/) do |hired_on|
  profile = build(:profile, hired_on: DateTime.parse(hired_on), pto_hours_used: 0)
  @employee = create(:user, profile: profile)
end

Given(/^today is (.*)$/) do |current_date|
  current_date = DateTime.parse(current_date)
  Timecop.freeze(current_date)
end

Given(/^I've requested (\d+) hours of PTO$/) do |pto_hours_requested|
  if Integer(pto_hours_requested) > 0
    @employee.pto_requests.create!(
      start_date: 1.day.from_now,
      end_date: 2.days.from_now,
      hours: pto_hours_requested
    )
  end
end

Given(/^I used (\d+) hours of PTO$/) do |pto_hours_used|
  @employee.profile.pto_hours_used = pto_hours_used
end

When(/^I inquire about my available pto hours$/) do
  @available_hours = PtoCalculator.instance(@employee).available_hours
end

Then(/^my available pto hours should be (.*)$/) do |expected_available_pto_hours|
  expect(format('%.2f', @available_hours)).to eq expected_available_pto_hours
end