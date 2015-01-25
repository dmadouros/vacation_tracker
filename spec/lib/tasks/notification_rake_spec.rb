require 'rails_helper'
require 'rake'

describe 'notifications' do
  before :all do
    load File.expand_path('../../../../Rakefile', __FILE__)
  end

  before do
    task.reenable
  end

  describe 'notification:monthly_report' do
    let(:task) { Rake::Task['notification:monthly_report'] }

    it 'should send monthly vacation report for the previous month' do
      notification_service = double('NotificationService')
      allow(NotificationService).to receive(:new).with(Date.new(2014, 12, 1)).and_return(notification_service)

      expect(notification_service).to receive(:send_monthly_report)

      Timecop.freeze(2015, 1, 24) do
        task.invoke
      end
    end

    it 'should send monthly vacation report for the month of a specific date' do
      notification_service = double('NotificationService')
      allow(NotificationService).to receive(:new).with(Date.new(2014, 12, 1)).and_return(notification_service)

      expect(notification_service).to receive(:send_monthly_report)

      task.invoke '20141231'
    end
  end
end
