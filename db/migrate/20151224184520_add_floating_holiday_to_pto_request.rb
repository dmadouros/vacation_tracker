class AddFloatingHolidayToPtoRequest < ActiveRecord::Migration
  def change
    add_column :pto_requests, :floating_holiday, :boolean, default: false
  end
end
