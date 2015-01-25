require 'rails_helper'

describe NotificationService do
  it 'should send users emails by delegating to the NotificationMailer' do
    user = create(:user, email: 'test@example.com')
    report_date = Date.current

    expect(NotificationMailer).
      to receive(:monthly_vacation_status).
           with(user, [], report_date).
           and_return(double.as_null_object)

    described_class.new(report_date).send_monthly_report
  end

  it 'should send the pto requests for the given month' do
    report_date = Date.new(2015, 1, 1)
    user = create(:user)

    pto_request_before_month = create(:pto_request, user: user, start_date: '01-Dec-2014', end_date: '02-Dec-2014')
    pto_request_during_month = create(:pto_request, user: user, start_date: '01-Jan-2015', end_date: '02-Jan-2015')
    pto_request_after_month = create(:pto_request, user: user, start_date: '01-Feb-2015', end_date: '02-Feb-2015')

    expect(NotificationMailer).
      to receive(:monthly_vacation_status).
           with(user, [pto_request_during_month], report_date).
           and_return(double.as_null_object)

    described_class.new(report_date).send_monthly_report
  end

  context 'when a pto request spans two months'
  let(:user) { create(:user) }
  let(:pto_request_spanning_two_months) { create(:pto_request, user: user, start_date: '30-Jan-2015', end_date: '02-Feb-2015') }

  it 'should include it in the starting month' do
    report_date = Date.new(2015, 1, 1)

    expect(NotificationMailer).
      to receive(:monthly_vacation_status).
           with(user, [pto_request_spanning_two_months], report_date).
           and_return(double.as_null_object)

    described_class.new(report_date).send_monthly_report
  end

  it 'should include it in the ending month' do
    report_date = Date.new(2015, 2, 1)

    expect(NotificationMailer).
      to receive(:monthly_vacation_status).
           with(user, [pto_request_spanning_two_months], report_date).
           and_return(double.as_null_object)

    described_class.new(report_date).send_monthly_report
  end
end