When(/^I inquire about my accrued pto hours$/) do
  @accrued_hours = PtoCalculator.instance(@employee).accrued_hours
end

Then(/^my accrued pto hours should be (.*)$/) do |expected_accrued_pto_hours|
  expect(format("%.2f", @accrued_hours)).to eq expected_accrued_pto_hours
end