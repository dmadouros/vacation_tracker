class NotificationService
  def initialize(report_date)
    @report_date = report_date
  end

  def send_monthly_report
    User.all.each do |user|
      NotificationMailer.monthly_vacation_status(
        user,
        pto_requests_for_reporting_period(user),
        report_date
      ).deliver
    end
  end

  private

  attr_reader :report_date

  def pto_requests_for_reporting_period(user)
    user.pto_requests.where(within_reporting_period)
  end

  def within_reporting_period
    <<-SQL
      start_date between '#{report_date}' and '#{report_date.end_of_month}'
    SQL
  end
end