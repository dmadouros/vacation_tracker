namespace :notification do
  desc 'Sends monthly vacation report to users'
  task :monthly_report, [:report_date] => :environment do |_task, args|
    report_date = args.report_date ? Date.parse(args.report_date) : Date.current.last_month

    NotificationService.new(report_date.beginning_of_month).send_monthly_report
  end
end