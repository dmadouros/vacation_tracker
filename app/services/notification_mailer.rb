class NotificationMailer < ActionMailer::Base
  def monthly_vacation_status(user, pto_requests, report_date)
    @pto_request_collection = PtoRequestCollection.new(pto_requests, user)
    @report_date = report_date
    @user = user

    mail(to: user.email, subject: subject_line_for(report_date), from: 'kbarnes@athn.org')
  end

  private

  def subject_line_for(report_date)
    "PTO Report for #{report_date.strftime('%B %Y')}"
  end
9end