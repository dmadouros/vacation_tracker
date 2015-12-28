class NotificationMailer < ActionMailer::Base
  def monthly_vacation_status(user, pto_requests, report_date)
    @pto_requests = presented_pto_requests(pto_requests)
    @total_hours = total_hours(pto_requests)
    @floating_holiday_hours = floating_holiday_hours(pto_requests)
    @report_date = report_date
    @user = user

    mail(to: user.email, subject: subject_line_for(report_date), from: 'kbarnes@athn.org')
  end

  private

  def subject_line_for(report_date)
    "PTO Report for #{report_date.strftime('%B %Y')}"
  end

  def total_hours(pto_requests)
    deductible_pto_requests(pto_requests) || 0
  end

  def floating_holiday_hours(pto_requests)
    pto_requests.select(&:floating_holiday?).map(&:hours).reduce(:+)
  end

  def deductible_pto_requests(pto_requests)
    pto_requests.reject(&:floating_holiday?).map(&:hours).reduce(:+)
  end

  def presented_pto_requests(pto_requests)
    pto_requests.map do |pto_request|
      PtoRequestPresenter.new(pto_request)
    end
  end
9end