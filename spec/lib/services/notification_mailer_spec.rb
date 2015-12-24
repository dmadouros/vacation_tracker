require 'rails_helper'

describe NotificationMailer do
  let(:user) { create(:user, email: 'test@example.com') }

  before { Timecop.freeze(DateTime.parse('25-Jan-2015'))}
  after { Timecop.return }

  it 'should send email with correct parameters' do
    email_args = {
      to: 'test@example.com',
      subject: 'PTO Report for January 2015',
      from: 'kbarnes@athn.org'
    }

    expect_any_instance_of(ActionMailer::Base).to receive(:mail).with(email_args)

    described_class.monthly_vacation_status(user, [], Date.new(2015, 1, 1))
  end

  describe 'subject line' do
    it 'should build the right subject line for the report month' do
      email_args = {
        to: 'test@example.com',
        subject: 'PTO Report for December 2014',
        from: 'kbarnes@athn.org'
      }

      expect_any_instance_of(ActionMailer::Base).to receive(:mail).with(email_args)

      described_class.monthly_vacation_status(user, [], Date.new(2014, 12, 1))
    end
  end

  it 'should include vacation requests for the previous month' do
    pto_requests = [create(:pto_request, user: user, start_date: '01-Jan-2015', end_date: '02-Jan-2015', hours: 8)]

    mail = NotificationMailer.monthly_vacation_status(user, pto_requests, Date.new(2015, 1, 1))

    expect(mail.body).to include 'I took the following time off this month:'
    expect(mail.body).to include 'Start'
    expect(mail.body).to include 'End'
    expect(mail.body).to include 'Hours'
    expect(mail.body).to include 'Type'
    expect(mail.body).to include '01-Jan-2015'
    expect(mail.body).to include '02-Jan-2015'
    expect(mail.body).to include '8'
    expect(mail.body).to include 'PTO'
  end

  it 'should include floating holiday requests for the previous month' do
    pto_requests = [
        create(:pto_request,
               user: user,
               start_date: '01-Jan-2015',
               end_date: '02-Jan-2015',
               hours: 8,
               floating_holiday: true,
        )
    ]

    mail = NotificationMailer.monthly_vacation_status(user, pto_requests, Date.new(2015, 1, 1))

    expect(mail.body).to include 'I took the following time off this month:'
    expect(mail.body).to include 'Start'
    expect(mail.body).to include 'End'
    expect(mail.body).to include 'Hours'
    expect(mail.body).to include '01-Jan-2015'
    expect(mail.body).to include '02-Jan-2015'
    expect(mail.body).to include '8'
    expect(mail.body).to include 'Floating Holiday'
  end

  it 'should total the pto hours' do
    pto_requests = [
        create(:pto_request, user: user, hours: 8),
        create(:pto_request, user: user, hours: 10),
        create(:pto_request, user: user, hours: 15),
    ]

    mail = NotificationMailer.monthly_vacation_status(user, pto_requests, Date.new(2015, 1, 1))
    expect(mail.body).to include 'Total PTO: 33.00 hours'
  end

  it 'should exclude floating holidays from the total hours' do
    pto_requests = [
        create(:pto_request, user: user, hours: 8),
        create(:pto_request, user: user, hours: 10),
        create(:pto_request, user: user, hours: 15, floating_holiday: true),
    ]

    mail = NotificationMailer.monthly_vacation_status(user, pto_requests, Date.new(2015, 1, 1))

    expect(mail.body).to include 'Total PTO: 18.00 hours'
  end

  it 'should include a special note about floating holidays' do
    pto_requests = [
        create(:pto_request, user: user, hours: 8, floating_holiday: true),
    ]

    mail = NotificationMailer.monthly_vacation_status(user, pto_requests, Date.new(2015, 1, 1))

    expect(mail.body).to include 'I took 8.00 hours of floating holiday this month.'
  end

  it 'should handle no vacation taken in the previous month' do
    mail = NotificationMailer.monthly_vacation_status(user, [], Date.new(2015, 1, 1))

    expect(mail.body).to include 'I took no time off this month.'
  end

  it 'should include the PTO summary' do
    mail = NotificationMailer.monthly_vacation_status(user, [], Date.new(2015, 1, 1))

    expect(mail.body).to include 'PTO Summary'
    expect(mail.body).to include 'Accrued PTO Hours:'
    expect(mail.body).to include '28.00'
    expect(mail.body).to include 'Available PTO Hours (by end of 2015):'
    expect(mail.body).to include '148.00'
  end
end