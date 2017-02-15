namespace :notification do
  desc 'Sends monthly vacation report to users'
  task :monthly_report, [:report_date] => :environment do |_task, args|
    report_date = args.report_date ? Date.parse(args.report_date) : Date.current.last_month

    NotificationService.new(report_date.beginning_of_month).send_monthly_report
  end

  desc 'Sends monthly vacation report to specific user'
  task :monthly_report, [:user_id, :report_date] => :environment do |_task, args|
    report_date = args.report_date ? Date.parse(args.report_date) : Date.current.last_month

    NotificationService.new(report_date.beginning_of_month).send_monthly_report_to(user_id)
  end
end
